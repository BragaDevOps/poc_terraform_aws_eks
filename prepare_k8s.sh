#!/bin/bash

set -ex

echo "#############################################";
echo "### PREPARE K8S"; 
echo "#############################################";

JSON_ROUTE53=$(terraform output -json aws_route53_zone)

DOMAIN=$(echo $JSON_ROUTE53 | jq -r '.name')
export DOMAIN=${DOMAIN%?}
export HOSTED_ZONE_ID=$(echo $JSON_ROUTE53 | jq -r '.zone_id')
export NAMES_SERVERS=$(echo $JSON_ROUTE53 | jq -r '.name_servers')

AWS_REGION=$(cat project.tfvars | awk '/AWS_REGION/ {print $3}')
AWS_REGION=${AWS_REGION#?}
export AWS_REGION=${AWS_REGION%?}

AWS_PROFILE=$(cat project.tfvars | awk '/AWS_PROFILE/ {print $3}')
AWS_PROFILE=${AWS_PROFILE#?}
export AWS_PROFILE=${AWS_PROFILE%?}

CLUSTER_NAME=$(cat project.tfvars | awk '/CLUSTER_NAME/ {print $3}')
CLUSTER_NAME=${CLUSTER_NAME#?}
export CLUSTER_NAME=${CLUSTER_NAME%?}

echo; aws eks update-kubeconfig --profile brg --region ${AWS_REGION} --name ${CLUSTER_NAME}
echo; kubectl get nodes -o wide

echo; kubectl apply -f kubernetes/ingress-nginx/ingress-nginx-deploy.yaml
echo; kubectl get pods --namespace=ingress-nginx

[ "$(ls -A ./kubernetes/certificate/)" ] && rm ./kubernetes/certificate/tls.*
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout kubernetes/certificate/tls.key -out kubernetes/certificate/tls.crt -subj "/CN=${DOMAIN}/O=${DOMAIN}"
(kubectl create secret tls tls-secret --key kubernetes/certificate/tls.key --cert kubernetes/certificate/tls.crt 2> /dev/null) | true
echo; kubectl get secret tls-secret

echo; kubectl apply -f kubernetes/apps/http-echo.yaml
echo; kubectl get service http-echo

echo; kubectl apply -f kubernetes/apps/hello-app.yaml
echo; kubectl get service hello-app

export ELB_DNS_NAME=$(kubectl get services --namespace=ingress-nginx | grep LoadBalancer | awk '/ingress-nginx-controller/ {print $4}')
export CANONIAL_HOSTED_ZONE_ID=$(aws elbv2 describe-load-balancers --profile $AWS_PROFILE | jq --arg ELB_DNS_NAME "$ELB_DNS_NAME" '.LoadBalancers[] | select(.DNSName | contains($ELB_DNS_NAME))' | jq -r '.CanonicalHostedZoneId')
envsubst < ./config/templates/change-resource-record-sets.json.template > change-resource-record-sets.json

$(aws route53 change-resource-record-sets --profile $AWS_PROFILE --region $AWS_REGION --hosted-zone-id $HOSTED_ZONE_ID --change-batch file://change-resource-record-sets.json 2> /dev/null) | true

echo; kubectl get ds --all-namespaces
echo; kubectl get services --all-namespaces
echo; kubectl get pods

echo 'Para testar as aplicações é necessario atribuir os SERVERS NAMES abaixo aos DNS do domínio "${DOMAIN}"'
echo $JSON_ROUTE53 | jq -r '.name_servers'

echo "Após o SERVER NAMES terem propagado, abra o terminal e teste as aplicações:"
echo "Execute para Ingress Nginx: c=0; while [[ c -lt 6 ]]; do ((c++)); echo; curl -k http://$DOMAIN/hello-app; done"
echo "Para tester a outra aplicação, execute: curl -k http://$DOMAIN/http-echo"
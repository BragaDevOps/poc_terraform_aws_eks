#!/bin/bash

set -ex

echo "#############################################";
echo "### PREPARE BACKEND"; 
echo "#############################################";

AWS_S3_TERRAFORM_BACKEND=$(cat project.tfvars | awk '/AWS_S3_TERRAFORM_BACKEND/ {print $3}')
AWS_S3_TERRAFORM_BACKEND=${AWS_S3_TERRAFORM_BACKEND#?}
export AWS_S3_TERRAFORM_BACKEND=${AWS_S3_TERRAFORM_BACKEND%?}

AWS_REGION=$(cat project.tfvars | awk '/AWS_REGION/ {print $3}')
AWS_REGION=${AWS_REGION#?}
export AWS_REGION=${AWS_REGION%?}

AWS_ACCOUNT_ID=$(cat project.tfvars | awk '/AWS_ACCOUNT_ID/ {print $3}')
AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID#?}
export AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID%?}

AWS_PROFILE=$(cat project.tfvars | awk '/AWS_PROFILE/ {print $3}')
AWS_PROFILE=${AWS_PROFILE#?}
export AWS_PROFILE=${AWS_PROFILE%?}

envsubst < ./config/templates/backend.tf.template > backend.tf
envsubst < ./config/templates/atlantis.yaml.template > atlantis.yaml

echo; cat backend.tf
echo; cat atlantis.yaml
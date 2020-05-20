export TERM=xterm-256color
export CLICOLOR_FORCE=true
export RICHGO_FORCE_COLOR=1

default: init validate plan apply prepare-k8s prepare-backend init plan apply


init: 
	@ echo "yes" | terraform init -var-file="project.tfvars"

fmt:
	@ terraform fmt

validate:
	@ terraform validate

plan:
	@ terraform plan -input=false -var-file="project.tfvars" -out=create.tfplan

refresh:
	@ terraform refresh -input=false -var-file="project.tfvars"

apply:
	@ terraform apply -input=false -auto-approve create.tfplan

prepare-k8s:
	@ ./prepare_k8s.sh

prepare-backend:
	@ ./prepare_backend.sh

k8s-clear-all:
	@ kubectl delete all --all --all-namespaces

destroy-plan:
	@ terraform plan -destroy -var-file="project.tfvars" -out destroy.tfplan

destroy: destroy-plan
	@ terraform apply destroy.tfplan
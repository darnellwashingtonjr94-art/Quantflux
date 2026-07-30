#!/bin/bash
# scripts/infra-apply.sh

set -e
ENV=${1:-"staging"}

echo "Applying Terraform infrastructure for $ENV environment..."
cd "infra/terraform/$ENV"

terraform init
terraform plan -out=tfplan
terraform apply "tfplan"

cd ../../../
echo "Infrastructure successfully provisioned."

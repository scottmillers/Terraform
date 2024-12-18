#!/bin/bash

# Run terragrunt to apply the Terraform configuration without any prompts

 terragrunt run-all --terragrunt-non-interactive apply -auto-approve

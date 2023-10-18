# Terraform to build the AWS environment for VM Import/Export

This repository contains my Terraform to build an environment to test the AWS VM Import/Export process.  The objective is to import the Cisco Catalyst 8000v software into AWS.

The script will create the S3 bucket, upload the Cisco Catalyst 8000v software and create the IAM roles and policies to allow the AWS VM import/export process to work.

Once the terraform is complete you can run the scripts in the [scripts](./scripts/) directory import the Cisco Catalyst 8000v software.


The [import-start.sh](./scripts/import-start.sh) script is the primary one to start the process.


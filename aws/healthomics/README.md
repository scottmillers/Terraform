# AWS HealthOmics

[AWS HealthOmics](https://aws.amazon.com/healthomics/) is a AWS solution that provides a secure, scalable, and cost-effective environment for processing, analyzing, and storing large-scale genomics data. It provides a set of pre-built workflows that can be used to analyze genomics data.

This directory contains the following files:

- `README.md` - This file.
- `docs/` - Directory containing documentation for AWS HealthOmics.
- `01-IdentityAndAccessManagement` - Directory contains terraform code that will create
    - A IAM group for the Bioinformatics team
    - A ServiceRole for the Omics Ready2Run workflows
    - A `scripts\variables.sh` file to which is used by the scripts in that directory to create new users. 
 

## Documentation

Here is a list of documentation in the `docs/` directory. 

- [Getting Started](docs/omics-run-r2r.md) - Steps to run your first AWS HealthOmics Ready2Run workflow.
- [Sample Data](docs/omics-workflows.md) - Sample data that the Bioinformatics team has uploaded which can be used to test the HaplotypeCaller WGS Ready2Run workflows.
- [Ready2Run Workflows](docs/omics-r2r-workflows.md) - How to find out more about the AWS HealthOmics Ready2Run workflows.

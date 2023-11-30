# AWS Omics

# References

- This is [Part1: Introducing Amazon Omics](https://aws.amazon.com/blogs/industries/part-1-introducing-amazon-omics-from-sequence-data-to-insights-securely-and-at-scale/) 
- This is [Part2: Automated End-to-End Genomics Data Storage](https://aws.amazon.com/blogs/industries/automated-end-to-end-genomics-data-storage-and-analysis-using-amazon-omics/) 


# Workflow Architecture

1. It sets up a S3 bucket with lifecycle rules to input raw sequencing data and workflow output data
2. Used AWS CodeBuild to build an deploy the necessary Lambda Functions and Docker Images (pushed to the accounts private Amazon Elastic Container Registry)
3. Amazon Omics resources necessary for data storage, secondary analysis workflow and variant data ingestion:
   1. Omics Reference Store and automated import of a reference genome.
   2. Omics Sequence Store.
   3. Omics Workflow and automated creation of an example Secondary Analysis workflow.
   4. Omics Variant Store (omicsvariantstore)
   5. Omics Annotation Store (omicsannotationstore) with an automated import of ClinVar VCF.
4. Step Functions workflows orchestrate data import into Omics Sequence and Variant Stores and an automated launch of the pre-created Omics Workflow. 
5. Lambda functions and Amazon S3 notifications trigger creation and launch of various resources.


# Steps 
1. Users upload raw sequence data in FASTQ format to the existing S3 bucket designated for inputs.
2. The input S3 bucket has an Amazon S3 Event Notification that is configured to trigger a Lambda function. The Lambda function evaluates the file names and triggers   the AWS Step Functions Workflow when a pair of FASTQs for the same sample name is detected.
3. The AWS Step Functions Workflow includes steps that invoke AWS Lambda functions to:
   1. Import the FASTQs into an existing Omics Sequence Store.
   2. Start the pre-created Omics Workflow that uses GATK best practices Omics Workflow for Secondary Analysis.
   3. Once the workflow is complete, import workflow output BAM and VCF into the Omics Sequence and Variant Stores respectively.
   4. Tag input and output files in Amazon S3 so that they lifecycle into colder storage tiers or get deleted over time.
4. The Variant store and Annotation store tables appear as resources in AWS Lake Formation.

# Query Variant Data
Variant and Annotation data imported into Omics Variant Store and Annotation store are surfaced as shared tables using Omic's integration with AWS Lake Formation. The omicsvariantstore and omicsannotationstore tables will appear in Lake Formation.  Once Lake Permissions are granted, users can access Variant and Annotation data using Amazon Athena.

# GitHub site

This is GitHub site to deploy the [Code and samples data](https://github.com/aws-samples/amazon-omics-end-to-end-genomics)

# AWS HealthOmics Sample Data

You can use the Sample data described in the specific AWS HealthOmics workflow page, or you can use the sample data from the Bioinformatics team.

The Bioinformatics FASTQ pair data is located in our `bioinformatics-nbs` S3 bucket.  The table below gives the full S3 URL for the FASTQ pair. The S3 URL can be used in the AWS HealthOmics Ready2Run workflow form. 



| FASTQ Pair      | Size (GB)   | S3 URL   |
| -------- | ------- |-------| 
| Small    | 17 GB   | `s3://bioinformatics-nbs/input_data/230616/WGS20230010-TX-VH00729-230616_S3_R1_001.fastq.gz`    |
| Small    | 18.1 GB    | `s3://bioinformatics-nbs/input_data/230616/WGS20230010-TX-VH00729-230616_S3_R2_001.fastq.gz`    |
| Medium    | 39.1 GB    | `s3://bioinformatics-nbs/input_data/230616/WGS20230004-TX-VH00729-230616_S2_R1_001.fastq.gz`    |
| Medium    | 41.2 GB    | `s3://bioinformatics-nbs/input_data/230616/WGS20230004-TX-VH00729-230616_S2_R2_001.fastq.gz`    |
| Large    | 44.5 GB    | `s3://bioinformatics-nbs/input_data/230616/WGS20230002-TX-VH00729-230616_S1_R1_001.fastq.gz`    |
| Large    | 47.5 GB    | `s3://bioinformatics-nbs/input_data/230616/WGS20230002-TX-VH00729-230616_S1_R2_001.fastq.gz`    |


You can also use the sample data from the AWS HealthOmics Ready2Run workflows.  The sample data is located in the `omics-<region>` S3 bucket.  The JSON file has the following:

```
{
    "inputFASTQ_1": "s3://omics-<region>/sample-inputs/7709200/HG002-NA24385-pFDA_S2_L002_R1_001-50x.fastq.gz",
    "inputFASTQ_2": "s3://omics-<region>/sample-inputs/7709200/HG002-NA24385-pFDA_S2_L002_R2_001-50x.fastq.gz"
}

For example, the 
```
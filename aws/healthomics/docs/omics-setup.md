# Getting Started with a AWS HealthOmics Ready2Run Workflow

## Prerequisites

Access to the AWS sandbox environment. You should have been been sent two emails
- The first is your account name and explains how to login to the AWS sandbox account 
- The second is your temporary password.  The first time you login you will have to change your password.  


## Steps to us a AWS HealthOmics Ready2Run Workflows


1. Login to the AWS Console
    - Go to https://console.aws.amazon.com/console/home?region=us-east-1
    - Select IAM user
    - Enter in the sandbox account number of 588459062833

2. Type your username and password
    - If this is the first time logging in you will be asked to change your password

3. Once logged in verify you are in the N. Virginia region.  
    - In the top right of your browser you should see this:
![Alt text](images/console-region.png). 
    - If you see another region change the region to be US-East (N. Virginia)

4. Go to the S3 buckets
    - In the search box type "S3" and select "S3" from the list
    - You should see a list of S3 buckets. ![Alt text](images/s3-bucket-list.png). 
    - The **bioinformatics-nbs** bucket is where our the HealthOmics data is stored.  If you upload any data store it here. You have full access rights to this directory.

5. Go to AWS HealthOmics
    - In the search box type "omics" and select "AWS HealthOmics" 
    - In the left menu select Ready2Run workflows
    ![Alt text](images/console-omics-menu.png)

6. Find the "NVIDIA Parabricks Germline HaplotypeCaller WGS for up to 50X" Ready2Run workflow 
    - In the Ready2Run workflows search box type "7709"
    ![Alt text](images/console-r2r-search.png)
    - Select the workflow and click the "Create run" button

7. Run the "NVIDIA Parabricks Germline HaplotypeCaller WGS for up to 50X"  workflow 
    - Give the Run a name (e.g. My First Run)
    - Set the output folder to be s3://bioinformatics-nbs/output_data/231201
    ![Alt text](images/omics-run-details.png)
  
    - For the Service role select OmicsWorkflowServiceRole and click next 
    ![Alt text](images/omics-run-servicerole.png)
    - Keep the default of Manually enter values
  
 
    - Use the following FASTQ files:
        `s3://bioinformatics-nbs/input_data/230616/WGS20230004-TX-VH00729-230616_S2_R1_001.fastq.gz`
        `s3://bioinformatics-nbs/input_data/230616/WGS20230004-TX-VH00729-230616_S2_R2_001.fastq.gz`

        ![Alt text](images/omics-run-entervalues.png)
        - Click the "Next" button        

    - At the bottom of the next page click the "Start run" button
        ![Alt text](images/omics-run-createrun.png)

8. Monitor the run
    - After you click the "Start run" button you will see a banner at the top of the page 
    ![Alt text](images/omics-run-started.png)
    - You can also see the run status of all "Runs" by clicking the "Runs" link in the left menu
    ![Alt text](images/omics-run-page.png)
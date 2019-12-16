# Terraform State via AWS

Terraform state can be held remotely. Here we are going to provision the necessary resources via AWS.

These resources consist of:

1. IAM 
2. S3 Bucket
3. DynamoDB 

Users provisioned within IAM will need 

The DynamoDB will have a table called ```tfstatelock```.

## Prerequesites

1. An AWS account
2. The Terraform software


# Remote State

Terraform has the ability to store its state file remotely.

The scripts in this folder will be to provision the necessary resources to allow other stages to host their state files remotely.

There are a few ways to accomplish this, but we are going to do this with ASW.

## AWS

First, you will need an AWS account.

Second, you will also need to manually provision the following:

- A user called 'terraform' with full access rights to:
    - IAM (?)
    - S3
    - DynamoDB

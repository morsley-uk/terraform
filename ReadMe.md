# Terraform

Terraform, by Hashicorp, does IaC (Infrastructure as Code).

This approach provisions infrastructure through software to achieve consistent and predictable environments. Manual deployments are the enemy. Everything should be automated!

IaC benefits:

- Automated deployments - Remove manual processes
- Consistent environments - Multiple attempts will be the same
- Repeatable process - Steps won't be forgotten
- Reusable components - Once determined, steps can be reused - D.R.Y.
- Documented architecture - Acts as a living documentation

Code is written in HCL (Hashicorp Configuration Language).

But where do we store Terraform's state file? We will address this in stage 2.

## Aim

The aim of this project is to provision, via Terraform, a Kubernetes cluster, on all major cloud providers: Azure, AWS and GCP. It's on this cluster that we will deploy our walking skeleton.

## Stages

### Stage 0 - Learning

Create an EC2 instance within AWS and enough infrastructure to hit that EC2 instance externally.

### Stage 1 - Remote State

Write Terraform script(s) that will provision the necessary resources to use remote state with Terraform for stage 2.

Not only should we be storing our Terraform scripts in a repository, but we should also be storing our Terraform state file remotely. This allows others to change our infrastructure via Terraform

Prerequisites:

- AWS account
- IAM (terraform)

What we will be creating:

- IAM (concourse)
- S3 bucket
- DynamoDB table

### Stage 2 - Concourse

Write Terraform script(s) that will provision the necessary resources for a Concourse CI/CD pipeline.

Prerequisites:

- AWS account
- IAM (concourse)
- S3 bucket
- DynamoDB table

What we will be creating?

- VPC
- Security Group
- EC2
- Public IP

### Stage 3 - Walking Skeleton

Write Terraform script(s) that will provision the necessary resources for a walking skeleton.

Prerequisites:

- AWS account
- IAM (walking-skeleton)

What we will be creating?

- VPC
- Security Group
- EC2
- EKS
- Public IP


## Basics

Terraform requires the Terraform executable.

This can be installed vis Chocolatey:

```
choco install terraform
```

To check that the Terraform software is installed, try:

```
terraform --version
```

When your code is ready to run:

```
terraform init
```

```
terraform plan -out=tf.plan
```

```
terraform apply -auto-approve "tf.plan"
```

```
terraform show
```

```
terraform output
```


```
terraform destroy
```

For a graphical representation of your Terraform infrastructure:

```
terraform graph | dot -Tsvg > graph.svg
```

This requires GraphViz to be installed and in your PATH:

http://www.graphviz.org/

For more details: https://www.terraform.io/docs/commands/graph.html

## Environment Variables

AWS

You can provide your AWS credentials via the following environment variable:

AWS_ACCESS_KEY_ID  
AWS_SECRET_ACCESS_KEY  

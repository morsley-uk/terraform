# Terraform

Terraform does IaC (Infrastructure as Code). 

## Aim

The aim of this project is to provision, via Terraform, a Kubernetes cluster, on all major cloud providers: Azure, AWS and GCP. It's on this cluster that we will deploy our walking skeleton.

## Stages

### Stage 1

Write Terraform script(s) that will provision the necessary resources to use remote state with Terraform for stage 2.

### Stage 2

Write Terraform script(s) that will provision the necessary resources for a Concourse Ci/CD pipeline.

### Stage 3

Write Terraform script(s) that will provision the necessary resources for a walking skeleton.

## Basics

```
terraform --version
```

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

```
terraform destroy
```

## Environment Variables

AWS

You can provide your AWS credentials via the following environment variable:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
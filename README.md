# Terraform GitHub Workflow

This repository contains code and configuration files for creating an AWS VPC using Terraform and GitHub Actions.

## Note*
Use this command to avoid tracking unnessary terraform tracking files:
git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/'

## Prerequisites

Before you can use this workflow, make sure you have the following prerequisites set up:

- An AWS account with appropriate permissions to create VPC resources.
- Terraform installed on your local machine.

## Getting Started

To get started with this application, follow these steps:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/your-username/terraform-github-workflow.git
    ```

2. Change into the project directory:

    ```bash
    cd terraform-github-workflow
    ```

3. Set up your AWS credentials by either configuring the AWS CLI or setting the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

4. Initialize the Terraform project:

    ```bash
    terraform init
    ```

5. Customize the `variables.tf` file to specify your desired VPC configuration.

6. Run Terraform to create the AWS VPC:

    ```bash
    terraform apply
    ```

7. Review the changes that Terraform will make and confirm by typing `yes` when prompted.

8. Wait for Terraform to provision the AWS VPC resources.

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow that automatically runs Terraform whenever changes are pushed to the `main` branch. The workflow is defined in the `.github/workflows/terraform.yml` file.

The workflow performs the following steps:

1. Checks out the repository code.
2. Sets up the AWS CLI and Terraform.
3. Runs `terraform init` to initialize the Terraform project.
4. Runs `terraform apply` to create or update the AWS VPC.

You can customize the workflow to fit your specific needs by modifying the `.github/workflows/terraform.yml` file.

## Cleanup

To clean up the AWS VPC resources created by this application, run the following command:

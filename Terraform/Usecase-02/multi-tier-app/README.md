# Multi-tier App (Terraform)

This repository contains a simple multi-tier application Terraform configuration that deploys a VPC, networking, security groups, compute instances, and an RDS instance.

## Repository structure

- `main.tf` - root module wiring submodules
- `variables.tf` - root-level variables and defaults
- `terraform.tfvars` - environment-specific values (region, AMIs, credentials omitted)
- `modules/`
  - `networking/` - VPC, public/private subnets, NAT/IGW
  - `security/` - security groups for web, app, db
  - `compute/` - EC2 web and app instances
  - `database/` - RDS instance and DB subnet group

## Prerequisites

- Terraform 1.x or later installed
- AWS CLI configured (credentials in `~/.aws/credentials` or environment variables)
- Permissions to create VPCs, subnets, EC2, ELB, RDS, Security Groups, EIPs

## Key variables

- `region` - AWS region to deploy (set in `terraform.tfvars`)
- `web_ami`, `app_ami` - AMI IDs for web and app instances (must match `region`)
- `instance_type` - EC2 instance type
- `db_username`, `db_password` - RDS credentials (password is marked sensitive)

Important: AMI IDs are region-specific. Ensure the AMI values in `terraform.tfvars` exist in the `region` you choose.

## Typical workflow

1. Initialize (no backend for local testing):

```bash
cd multi-tier-app
terraform init -backend=false
```

2. Validate configuration:

```bash
terraform validate
```

3. Plan:

```bash
terraform plan -out=tfplan
```

4. Apply:

```bash
terraform apply "tfplan"
```

5. When finished, destroy resources:

```bash
terraform destroy
```

## Notes and troubleshooting

- RDS requires a DB subnet group that covers at least two AZs — the networking module creates two private subnets and outputs `private_subnet_ids`.
- If you get `InvalidAMIID.NotFound`, the AMI ID does not exist in the selected region — pick a valid AMI for that region.
- If you see language-server errors in your editor about module variables, run `terraform init` and `terraform validate` to refresh module indexing.

## Outputs

After a successful apply the module outputs include things like EC2 instance IDs and RDS endpoint (check `modules/*/outputs.tf`).

### Deployment Outputs

The following outputs were produced by the last deployment:

```
app_instance_id   = "i-030dbe6ab34b02da8"
private_subnet_id = "subnet-04269e5a1fcefc167"
public_subnet_id  = "subnet-002067b4583e2edf2"
rds_endpoint      = "terraform-20260129212637663900000003.ckf6wqg46lcs.us-east-1.rds.amazonaws.com:3306"
vpc_id            = "vpc-031e4f12e2261a695"
web_instance_id   = "i-0b25e9b45647aed57"
```

## Next steps / enhancements

- Replace hardcoded AMIs with a data lookup (e.g., `data "aws_ami"`) for reproducible builds.
- Add backups and automated snapshot policy for RDS.
- Add monitoring (CloudWatch alarms) and logging configuration.


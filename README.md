## Terraform: Simple EC2 + RDS on Default VPC

This is a minimal, ready-to-run Terraform project that:
- Creates an EC2 instance in your account’s default VPC and assigns an Elastic IP
- Configures a web-friendly security group (SSH from your IP, HTTP/HTTPS open)
- Creates an RDS PostgreSQL database in private subnets (not publicly accessible)
- Enables daily automated backups with 7‑day retention
- Outputs the EC2 details and the RDS endpoint

### What this uses
- Your AWS account’s default VPC and its subnets (no custom VPC code here)
- Variables from `variables.tf` with values filled via `terraform.tfvars`

## File-by-file guide (what each file does)
- `provider.tf`: Sets the AWS provider region and profile using variables.
- `main.tf`: Looks up the default VPC and its subnets (data sources). Everything is built in that VPC.
- `security-group.tf`: Security group for the EC2 instance.
  - Inbound: SSH from your `office_ip`; HTTP/HTTPS from anywhere (for demos).
  - Outbound: All.
- `ec2.tf`: Launches the EC2 instance.
  - Uses your AMI, instance type, key pair, and attaches the security group.
  - Root EBS volume is gp3, encrypted, with sensible defaults.
- `eip.tf`: Allocates and associates an Elastic IP to the EC2 instance.
- `rds.tf`: Creates the RDS database and its networking.
  - Subnet group built from default subnets.
  - RDS security group allows DB traffic only from the EC2 security group.
  - Not publicly accessible; backup retention set to 7 days.
- `variables.tf`: Declares all input variables used by the project.
- `terraform.tfvars`: Sample values to make the project run quickly. Edit these for your environment.
- `outputs.tf`: Prints useful values (EC2 IDs/IPs/DNS, RDS endpoint, etc.).
- `.gitignore`: Keeps Terraform state and local-only files out of Git.
- `readme.txt`: Simple note file (kept for legacy/reference).

## Prerequisites
- AWS account with a default VPC in your chosen region
- Terraform installed (check with `terraform -v`)
- AWS credentials configured (e.g., via `~/.aws/credentials` with a profile)

## Quick start (short and simple)
1) Edit `terraform.tfvars`:
   - `region`, `aws_profile`
   - `ami_id` (valid for your region), `instance_type`, `key_name`
   - `office_ip` (your public IP with /32, e.g. `1.2.3.4/32`)
   - Optional DB settings (engine, instance size, etc.).
2) Initialize:
```powershell
terraform init
```
3) Preview changes:
```powershell
terraform plan
```
4) Apply (provisions resources):
```powershell
terraform apply -auto-approve
```
5) See outputs:
```powershell
terraform output
```

## How to connect (after apply)
- EC2 SSH (example for Amazon Linux):
```powershell
ssh -i <your-key>.pem ec2-user@<EC2_PUBLIC_DNS>
```
- RDS from EC2 (PostgreSQL):
```bash
psql -h <RDS_ENDPOINT> -U <db_username> -d <db_name> -p 5432
```
Tip: RDS is not publicly accessible; connect from the EC2 instance (or a bastion/VPN).

## Clean up
```powershell
terraform destroy -auto-approve
```

## Troubleshooting
- No default VPC/subnets in region: create a default VPC or adapt the code to a custom VPC.
- Invalid AMI: choose a region-appropriate AMI ID.
- Access denied: verify your AWS profile/credentials and IAM permissions.
- RDS password handling: set a strong value in `terraform.tfvars` or pass via `TF_VAR_db_password`.
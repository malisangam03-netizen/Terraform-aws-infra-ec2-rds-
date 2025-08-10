command:-
terraform init → Downloads providers & modules, initializes backend.
terraform validate → Checks syntax errors in your Terraform files.
terraform fmt → Auto-formats code for consistent styling. (clean and formate the .tf file)
terraform plan → Shows what changes Terraform will make (dry run).
terraform apply -auto-approve → Applies changes without manual confirmation.
terraform destroy → Deletes all managed infrastructure.
terraform state list → Lists all resources tracked in the state file.
terraform show → Displays current state in a readable format.
terraform state mv <source> <destination> → Renames/moves a resource in state (not in AWS).
terraform state rm <resource> → Removes resource from state (but not from AWS).

Bonus Commands:-
terraform refresh → Syncs state with real-world infrastructure.
terraform output  # Shows VPC ID, subnet ID, and EC2 public IP
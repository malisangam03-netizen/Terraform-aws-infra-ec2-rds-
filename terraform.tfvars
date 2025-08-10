
region        = "ap-south-1"
aws_profile   = "default"
ami_id        = "ami-0d54604676873b4ec"
instance_type = "t2.micro"
key_name      = "test"
environment   = "dev"
office_ip     = "45.64.206.4/32"
volume_size   = "10"

# RDS configuration
# engine choices: postgres | mysql | mariadb | sqlserver-* | oracle-*
db_engine            = "postgres"
db_engine_version    = "14.11"
db_instance_class    = "db.t3.micro"
db_allocated_storage = "20"
db_name              = "appdb"
db_username          = "appuser"
# REPLACE with a secure password or use TF_VAR_db_password env var
db_password          = "ChangeMe_Secure123!"
db_port              = "5432"
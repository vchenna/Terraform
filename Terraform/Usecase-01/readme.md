**Terraform Usecase-01: Launching an EC2 Instance with Variables and Outputs**

**Overview:**
This use case demonstrates how to use Terraform to provision an AWS EC2 instance by defining variables and outputs. It is a beginner-friendly example that introduces Terraform basics such as providers, resources, variables, outputs, and state management.

**Folder Structure:**

Usecase-01/
├── main.tf              # Defines AWS provider and EC2 instance resource
├── variables.tf         # Declares input variables
├── outputs.tf           # Declares outputs (instance ID, public IP)
├── terraform.tfvars     # Provides values for variables
├── terraform.tfstate    # State file (auto-generated)
├── terraform.tfstate.backup # Backup of state file

**Files Explained:**

1. variables.tf:
Declares variables like instance_type, region, and ami_id.
Makes the configuration reusable across environments.

2. main.tf:
Configures the AWS provider using the region variable.
Defines the EC2 instance resource using AMI ID and instance type variables.
Adds security groups and key pairs for SSH access.
Adds tags for identification.

3. outputs.tf:
Prints the EC2 instance ID and public IP after deployment.
Useful for referencing in other modules or scripts.

4. terraform.tfvars:
Provides actual values for variables (e.g., t2.micro, us-east-1, AMI ID).
Keeps sensitive or environment-specific values separate from code.

5. terraform.tfstate & terraform.tfstate.backup:
Tracks the current state of infrastructure.
Ensures Terraform knows what resources exist to avoid duplication.

**Execution Steps:**

1. Initialize Terraform --> terraform init
Downloads AWS provider plugin.

2. Validate Configuration --> terraform validate

3. Plan Deployment --> terraform plan
Shows what resources will be created.

4. Apply Deployment --> terraform apply
Provisions the EC2 instance. Outputs will display:
instance_id = "i-xxyyxxyyxyx"
public_ip   = "x.y.z.w"

5. Destroy Infrastructure (Cleanup) --> terraform destroy


**Expected Outcome:**
After terraform apply, Terraform will:
1. Launch an EC2 instance using the provided variables.
2. Display the instance ID and public IP.
3. Able to connect to the launced EC2 instance with key-value pair and public IP created above.
>> ssh -i key-value-pair.pem ec2-user@x.y.z.w


**Purpose:**
This use case helps to understand how to:
1. Parameterize infrastructure with variables.
2. Output useful resource information.
3. Manage state files for tracking infrastructure.


**Final Points:**
This foundational setup can be extended to:
1. Add security groups and key pairs for SSH access.
2. Create reusable modules for EC2, VPC, and networking.
3. Manage multiple environments (dev, staging, prod).

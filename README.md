# project-1
## Week 1 project for T-22-DEV-01

**- Create a new repository for your project. (give `project-1` title for your repo)**

**- Have main.tf, providers.tf, variable.tf, output.tf. (Use all files as intended)**
	
**- Create two users (one user will be your name, another user will be your trainer’s name) on Azure with Terraform. Use correct argument in your configuration to force your trainer to change their passwords when s/he logins. (Create it as a two different resource blocks)**
	*I created two "azuread_user" resources, one for myself and one for you, and filled out the fields as appropriate. I included the "force_password_change" field for both but only set the required one as true.*

**- Create four different users (usernames will be your classmates) on Aws by using `for_each` with Terraform.**
	*I created the 4 users using a list variable and toset to create one "aws_iam_user" for each entry in the list.*

**-Create two S3(Simple Storage Service) bucket using `count` with Terraform.**
	*I created a variable for the count and added a count field in the resource entry "aws_s3_bucket" to use that variable.*

**- Create a Resource Group, Virtual Machine and Storage Account with Terraform. Use same Resource Group for every Azure resource.**
	*I created the resources using the examples provided from HashiCorp's documentation. I used the resource group from the quick start for Azure, and made sure that all subsequent resources would use this RG. After adding and modifying the VM resource entries and all related networking resources, when I added the storage account, I used the existing network entries in my main.tf so as not to create multiple network resources.*

**- Use 2 tags at least in your configuration.**
	*I created two tags for the resources that were created for the RG.*

**- Use 1 output at least in your configuration.**
	*I created outputs for some the fields that are constructed in the main.tf file so we can see in the output whether they are concatenated properly.*

**- Use variables as much as you can.**
	*I created variables for any information that I found repeated in the configurations, as well as for data that might be best served as a variable, such as a hostname for the VM OS.*

**- Use main.tf for all resources.- Keep both provider`s information in provider.tf.**

**- Then, explain your project with short details by creating ReadMe.md file.**

**- Lastly, push your project with ReadMe.md file and notify your trainer by sending your repository link.**
# Terraform

## Why Terraform?
- Infrastructure as a code
- Infrastructure can be in different platforms/providers and using terraform we can create infrastructure in one place as a code
- Terraform can be used with any cloud provider

## Ansible vs Terraform
- Ansible module can be used to create infra.
- Ansible used for configuration management
- Terraform can be used for infrastructure management
- Use terraform when there is no infra. and you have to design infra. from scratch
- Now infra is ready and you want to deploy your application, so configuration for these can be done using Ansible or puppet.
- Terraform maintains the state of the resource created.
- To delete infra. in ansible you have to write a new file for the same, but not the same for terraform.
- OS level configuration - Ansible
- Terraform - Infra creation

## Install
- Install Terraform 
- Install `Hashicorp Terraform` VSCode extension
- Configure path

<hr/>

## 01 - Hello World

```terraform
// block "label1" label2 {
    // identifier = expression
//}

// this is first comment
# this is second comment

```

- `terraform plan`

<hr/>

## 02 - Hello World JSON

- `filename.tf.json`
- don't write in this format
- `.tf` use more
- `.tf.json` - when creating web application, json format is used for better automation

<hr/>

## 03 - Multiple Block in Single Terraform block

- Problem may arise when creating multiple infra from multiple blocks
- may cause problems in complex infra
- destructuring it is a better solution
- concern of separation is needed

<hr/>

## 04 - Multiple Terraform in Same Directory
- Terraform runs all `.tf` files in the current directory
- Files load in alphabetical order

<hr/>

## 05 - Variable

- `variable abc {}`
- `var.abc`
- dont use it inside string
- inside string, use `${abc}`
- use file destructer too

<hr/>

## 06 - Pass variable value from command line

- `terraform plan -var "username=Barun"`

<hr/>

## 07 - Multiple Variable

```terraform
variable username {
    default = "Barun"
}
```

- `terraform plan -var "username=Barun" -var "age=20"`

<hr/>

## 08 - Variable Type
- List
- List of string
- Object
- [Docs](https://developer.hashicorp.com/terraform/language/expressions/types)
- `type=variableType`

<hr/>

## 09 - List Variable
- `type = list`
- enter list variable in command line:
    - `["A", "B", "C"]

<hr/>

## 10- Functions
- `terraform plan -var 'users=["A", "B", "C"]'`
- [Docs]https://developer.hashicorp.com/terraform/language/functions
- `value="${join(",", var.users)}`
- `lower`
- `upper`
- `title`
- `zipmap` (imp.)

<hr/>

## 11 - Map Variable
- `type = map`
- `lookup`

<hr/>

## 12 - Terraform Variable Files `TFVARs`
- `terraform.tfvars`
- `terraform plan --help | less`
- `terraform plan -var-file=development.tfvars`

<hr/>

## 13 - Read Environment Variable
- `export TF_VAR_variableName=value`
- `terraform plan -lock=false`

<hr/>

## 14. Terraform Core and Plugin
- ![Terraform Plugin Architecture](https://jayendrapatil.com/wp-content/uploads/2020/11/Terraform_Architecture.png)
- ![Terraform_Architecture](https://miro.medium.com/max/1400/1*98PgDO6d984btl2VdZciOw.png)

<hr/>

## 15. Creating first Terraform Resource - Github Repository
- [Github Provider](https://registry.terraform.io/providers/integrations/github/latest)
- [Github Create Repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository)
- `terraform providers`
- `terraform init`
    - `file filename_vxxx`
- `terraform plan`
- `terraform apply` - authentication error
    - use github personal access token
- [test repo](https://github.com/d-cryptic/first-repo-from-terraform)
- `terraform.tfstate`
    - Dont manually udpate `tfstate` file
    - `terraform plan` - compares terraform.tf and terraform.tfstate file and creates resource not present in `.tfstate` file
- `terraform apply --auto-approve`
- `terraform.tfstate.backup` - backup the resource state before you applied `terraform apply`
- `terraform destroy`
- `terraform destroy --help`
- `terraform destroy --target github_repository.terraform-second-repo`
- `terraform validate`
- `terraform refresh` - updates `.tfstate` by fetching manually update resource details
- `terraform show`
- output
    - `terraform output resource_name`
- `terraform console` - read variables from current directory in a console 
    - `var.variableName`
- `terraform fmt` - does a formatting of the terraform variables

<hr/>

## 16 - Creating Resource on AWS
### Manual Steps:
    1. EC2 instance
    2. instances
    3. Ubuntu 18.04 - AMI ID (varies according to region)
        - copy AMI code
    4. t2 micro, 1 instance - default 
    5. storage - default
    6. tag: name: testVM
    7. configure-security - only ssh, port 22
    8. Review and Launch
    9. create new key pair
    10. `chmod 400 xyz.pem`
    11. `ssh -i "xyz.pem" ubuntu@abc.compute-1.amazonaws.com`

### Using Terraform:
    1. `provider aws {....}`
    2. [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    3. IAM - Add user
    4. Create Key Pair - Copy AMI, Secret Key, Access Key
        - Give administrator access first
    5. `terraform init`
    6. `terraform plan`
    7. `terraform apply --auto-approve`
    8. Terraform divided into two parts:
        - Core
        - Plugin
    9. `terraform show`
    10. `terraform fmt`
    11. Problems: 
        - Default security group
        - No SSH key pair for connection
    12. `terraform destroy`

### Attaching key to VM instance

- Tasks:
    1. ssh-key -> first-key
        - assign first-key to newly created instance
    3. create a security group
    4. assign that group to instance
    5. Install nginx
        - /var/www/html/index.nginx-default.html -> hey, Barun
    6. 

- Steps:
    1. `ssh-keygen -t rsa`
        - location - default
    2. key-value pair
        - attach ssh public/private key to VM instance
        - if not able to SSH, problem with security group
    3. creating security group using terraform 
    4. Attach security group to instance
        - `ssh -i privatekeyfile username@ip`
    5. `sudo -i`
        - `apt-get update`
        - `ping 8.8.8.8`
        - can't be accessed incoming from outide
        - only outgoing from anywhere
        - add egress block
        - now it will work
        - install nginx - check if it is working
            - IP address to access - public ip address
    6. Project structure
    7. `export TF_VAR_access_key=...`
        - `export TF_VAR_secret_key=...`
        - `env | grep -i access_key`
    8. Added shellscript to automate nginx installation and editing html file 
    - shellscript directly automating not a good practice
        - sometimes error may occur and you wont know
        - Best approach - use configuraiton management tool
        - Other ways - Terraform Provisioners (Not recommended)
<hr/>

## Dynamic Block in Terraform
```terraform
dynamic "abc" {
    for_each=[a,b,c,d]
    iterator=x
    content{
        data=x.value
    }
}
```

<hr/>

## Terraform Taint
- `terraform taint resource.name`
- shows the resource is damaged
- will destroy/delete old resource, then recreate the new ones
- not recommended
- use `terraform apply --refresh`

<hr/>

## File Provisioner
- three types:
    1. file
    2. local-exec
    3. remote-exec
- If provisioner not runned successfully, then that particular resource will be marked as `tainted`.
- Infinite cycle on calling its own resource
    - use `self`
- File Provisioner:
    - source
    - destination
    - connection
    - content
        - copy file
        - text
        - copy folder
- `local-exec`:
    - command runs on local machine where terraform is running
    - arguments:
        - command
        - working_dir
        - interpreter
        - environment
    - `when`
- `remote-exec`:
    - Failure Behavior:
        1. `continue`
        2. `fail`
    - `on_failure: continue`
    - runs commands inside resource group
    - types:
        - inline
    - terraform don't change/store the state of scripts/configuration etc.

<hr/>

## Datasource
- Image ID `ami` can be changed by AWS - its not static
- so instead of giving ami, you tell AWS the configurations:
    - root device type
    - storage type
    - Virtualization type, etc.
- It returns a image type using DataSource
- [Doc](https://developer.hashicorp.com/terraform/language/data-sources)

<hr/>

## Terraform configurations
- Working in team
- running before terraform commands - plan/apply/etc. check if specific terraform version exists or not
- Terraform version constraints
- can't define variables
- only accept hard-coded variables

<hr/>

## Terraform Graph
- show allocated resources in graph format
- `sudo apt install graphviz`
- `terraform graph | dot -Tpdf graph.pdf`

<hr/>

## Terraform workspace
- `dev.terraform.tfvars`
- `prod.terraform.tfvars`
- `terraform plan --var-file=dev.terraform.tfvars`
- `terraform plan --var-file=prod.terraform.tfvars`

### Workspace 
- List default workspace 
    - `terraform workspace list`
- `terraform workspace new workspaceName`
- `terraform workspace show`
- `terraform.tstate.d`
    - contains directory of each workspace
- `terraform workspace select workspaceName`
- `terraform workspace list`
- workspace - apply tfstate file forms inside separate directory inside tf.state.d folder
- `terraform workspace delete  workspaceNameOtherThancurrentWorkspace`
    - can't delete default workspace

<hr/>

## Terraform Modules
- Reusuable code 
- `terraform init`
    - initializer modules, providers, backends

<hr/>

## Terraform Backends
- Terraform s3 backend
    - working in team may replace the present infra
    - keep the tfstate file in remote location
    - dont keep inside `git`
    - not a best practice
    - many times developer forget to pull/push
- Terraform provide some backends to resolve the issue
    - any backend install - take care AWS/GCP/etc. CLI is already installed
    - S3 bucket to store tfstate file 
    - take care of s3 bucket cli access

<hr/>

## Terraform Migrate Backend
- `terraform init -migrate-state`
- stored in local system

<hr/>

## Remote backend state locking using S3 and DynamoDB
- when two users updates tfstate file - might change file 
    - how to solve this
- adding an entry that a particular user is changing file and others cant
    - using DynamoDB
- in S3 backend, you can also use versioning
- will show error if at same time, another user does `terraform apply`

Terraform Azure Deployment
The Architecture is shown in the picture, the picture is taken from: https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_07-Manage_Azure_Storage.html#estimated-timing-40-minutes

Knowledge wise you must be familiar with simple Terraform commands

Steps to proivision: 1. Preferably download the repository

2. Make sure you are signed in to your Azure account and have set the right subscription to provision resources to.

3. Running "terraform init" Initializes a working directory containing Terraform configuration files.

4. Running "terraform fmt" rewrites Terraforms configuration files to a canonical format and style. good for readability.

5. Running "terraform validate" checks the syntax and internal consistency of Terraforms configuration files.

6. Running "terraform plan" creates an execution plan and displays what will be deployed when running "terraform apply".

7. Running "terraform plan -out ./run-this-deployment.tfplan" creates an execution plan and saves it to the file specified.

8.  Running "terraform apply -out ./run-this-deployment.tfplan" applies the deployment/changes proposed in "./run-this-deployment.tfplan".

To access the Blobs you need to login to the VM with you azure credentials as we've set the allow only on the VMs IP-address.

There are many more commands, for starters this will be more than enough!

If running on windows, a good visualizer is Graphviz however many people encounter an error. (HTML code is displaying and not a resource visualization). Try: terraform graph -type=plan | dot -Tpng -o graph.png

Have fun!
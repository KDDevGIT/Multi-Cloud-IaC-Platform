- install AWS CLI: winget install -e --id Amazon.AWSCLI
- aws configure
- aws sts get-caller-identity

- install Azure CLI: winget install -e --id Microsoft.AzureCLI
- az login
- az account show 

### If you have issues
- az account clear
- az config set core.enable_broker_on_windows=false
- az login
- az account show


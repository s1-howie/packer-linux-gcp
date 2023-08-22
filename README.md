# packer-gcp-linux
 An example [Packer](https://www.packer.io/) template for creating Linux-based Images in GCP with the SentinelOne Linux agent "baked in".

## Detailed Description
This Packer template is an example of how one might go about automating the inclusion of SentinelOne Linux agents into GCP images.  During the packer build, the template will use a shell provisioner to download and execute an installer script that will handle the installation/configuration of the SentinelOne Linux agent.  The script requires 4 parameters that will be passed as variables from the variables.auto.pkrvars.hcl file.  You'll need to edit this file to provide your own customized values for these variable.

# Pre-Requisites
You must have [packer](https://developer.hashicorp.com/packer/downloads) installed on your build host.

You will also need access to a SentinelOne Management console to obtain:
- A [Service Account Token](https://support.sentinelone.com/hc/en-us/articles/9274954401687-Creating-Service-Users) in order to authenticate/download installer packages from the SentinelOne Management console.
- A [Site Token](https://support.sentinelone.com/hc/en-us/articles/360019996013-Getting-a-Site-or-Group-Token) that will be assigned to your SentinelOne Linux agents.

You will need access to Google Cloud with permissions to create Compute Engine Instances and Images.  

# Usage Instructions
1. Clone this repo
```
git clone https://github.com/s1-howie/packer-linux-gcp.git
```
2. Change into the packer-linux-gcp directory
```
cd packer-linux-gcp
```
3. Remove the "changeme" extension from the variables.auto.pkvars.hcl.changeme file
```
mv variables.auto.pkvars.hcl.changeme variables.auto.pkvars.hcl
```
4. Edit the variables.auto.pkvars.hcl file and customize for your environment.  NOTE:  Use the 'source_image_family info' area to find the appropriate source_image_family and ssh_username values.
5. Initialize packer
```
packer init
```
6. Perform a Packer build
```
packer build .
```
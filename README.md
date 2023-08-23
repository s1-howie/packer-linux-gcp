# packer-gcp-linux
 An example [Packer](https://www.packer.io/) template for creating Linux-based Images in GCP with the SentinelOne Linux agent "baked in".

## Detailed Description
This Packer template is an example of how one might go about automating the inclusion of SentinelOne Linux agents into GCP images.  During the packer build, the template will use a shell provisioner to download and execute an installer script that will handle the installation/configuration of the SentinelOne Linux agent.  The script requires 4 parameters that will be passed as variables from the variables.auto.pkrvars.hcl file.  You'll need to edit this file to provide your own customized values for these variable.

# Pre-Requisites
You must have [packer](https://developer.hashicorp.com/packer/downloads) installed on your build host.

You will also need access to a SentinelOne Management console to obtain:
- A [Service Account Token](https://support.sentinelone.com/hc/en-us/articles/9274954401687-Creating-Service-Users) in order to authenticate/download installer packages from the SentinelOne Management console.
- A [Site Token](https://support.sentinelone.com/hc/en-us/articles/360019996013-Getting-a-Site-or-Group-Token) that will be assigned to your SentinelOne Linux agents.

You will also need access to Google Cloud (via the [gcloud](https://cloud.google.com/sdk/docs/install) CLI) with permissions to create Compute Engine Instances and Images.  


# Usage Instructions
NOTE:  These instructions have only been tested on Mac and Linux build hosts.

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
mv  variables.auto.pkrvars.hcl.changeme  variables.auto.pkrvars.hcl
```
4. Edit the variables.auto.pkvars.hcl file and customize for your environment.  
<br />NOTE:  Use the 'source_image_family info' area to find the appropriate source_image_family and ssh_username values.
```
vi variables.auto.pkrvars.hcl
```
5. Get temporary GCP credetials via gcloud
```
gcloud auth login
```
6. Initialize packer
```
packer init .
```
7. Perform a Packer build
```
packer build .
```
<br />

The build will take a few minutes to complete.  To see your new image in the [GCP Console](https://console.cloud.google.com/), select your Project and search for "Images" (Compute Engine). 
You should see an image with a name pattern of "packer-<source_image_family>-s1-<timestamp>".  ie:  packer-rhel-9-s1-20230822224125 

When you create new instances from this image, the Linux agent will automatically register to your SentinelOne Management console using the Site Token you used in the template.
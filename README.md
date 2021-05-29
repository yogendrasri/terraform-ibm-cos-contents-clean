# Starter kit for a Terraform module

This is a Starter kit to help with the creation of Terraform modules. The basic structure of a Terraform module is fairly
simple and consists of the following basic values:

- README.md - provides a description of the module
- main.tf - defiens the logic for the module
- variables.tf (optional) - defines the input variables for the module
- outputs.tf (optional) - defines the values that are output from the module

Beyond those files, any other content can be added and organized however you see fit. For example, you can add a `scripts/` directory
that contains shell scripts executed by a `local-exec` `null_resource` in the terraform module. The contents will depend on what your
module does and how it does it.

## Instructions for creating a new module

1. Update the title and description in the README to match the module you are creating
2. Fill out the remaining sections in the README template as appropriate
3. Implement your logic in the in the main.tf, variables.tf, and outputs.tf
4. Use releases/tags to manage release versions of your module

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

## Example usage

## In this terraform module we are using MinIO

##MinIO
### MinIO installation
wget https://dl.min.io/client/mc/release/linux-amd64/mc
### MinIO permissions
 chmod +x mc
 ### test setup
 ./mc --version
### MinIO configration 
mc config host add <ALIAS> <COS-ENDPOINT> <ACCESS-KEY> <SECRET-KEY> 
### MinIO delete bucket contents
./mc rm cos/<bucket name>/ --recursive --force


Other options 

##Install rclone

cd && curl -O https://downloads.rclone.org/rclone-current-osx-amd64.zip

unzip -a rclone-current-osx-amd64.zip && cd rclone-*-osx-amd64

sudo mkdir -p /usr/local/bin
sudo mv rclone /usr/local/bin/

cd .. && rm -rf rclone-*-osx-amd64 rclone-current-osx-amd64.zip

For more details please refer https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-rclone

##Configure rclone

rclone config

No remotes found - make a new one
        n) New remote
        s) Set configuration password
        q) Quit config
        n/s/q> n

yks is the name given for this configuration
name> <YOUR NAME>

Type of storage to configure
Select S3 storage

Choose your S3 provider.
IBMCOS

Get AWS credentials from runtime (environment variables or EC2/ECS meta data if no env vars).
False

AWS Access Key ID
access_key_id
secret_access_key

Region to connect to.
2 / Use this only if v4 signatures don't work, e.g. pre Jewel/v10 CEPH.
   \ "other-v2-signature"

Endpoint for IBM COS S3 API
1 / US Cross Region Endpoint
   \ "s3.us.cloud-object-storage.appdomain.cloud"

Location constraint - must match endpoint when using IBM Cloud Public.
1 / US Cross Region Standard
   \ "us-standard"

Canned ACL used when creating buckets and storing or copying objects.
1 / Owner gets FULL_CONTROL. No one else has access rights (default). This acl is available on IBM Cloud (Infra), IBM Cloud (Storage), On-Premise COS
   \ "private"

Edit advanced config? (y/n)
y) Yes
n) No (default)
y/n> n

Remote config
--------------------
[yks]
type = s3
provider = IBMCOS
env_auth = false
access_key_id = < IBM COS access_key_id>
secret_access_key = < IBM COS secret_access_key>
region = other-v2-signature
endpoint = s3.us.cloud-object-storage.appdomain.cloud
location_constraint = us-standard
acl = private
--------------------


y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> y

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q

##To create a bucket:
rclone mkdir yks:newyksbucket001  

##To delete a file
rclone delete yks:newyksbucket001/file.txt

##To delete a directory
rclone purge  yks:newyksbucket001/rclone

##To delete bucket
rclone mkdir yks:newyksbucket001

##To list buckets
rclone lsd yks:

##To list contents of a bucket
rclone ls yks:newyksbucket001  


### Remove flow log files from COS bucket
The easiest way to remove flow logs from a COS bucket to help with a terraform destory is use the AWS S3 CLI. The following steps will help clear these logs files down.
1. Install the [AWS CLI](https://aws.amazon.com/cli/)
2. Configure Credentials for the IBM Cloud COS instance and select role as **Manager** and switch **Include HMAC Credential** as true
3. Edit the `~/.aws/credentials` file and config the following values
    ```
    [default]
    aws_access_key_id = <cos_hmac_keys/->access_key_id>
    aws_secret_access_key = <cos_hmac_keys/->secret_access_key>
    region=us-south
    ```
4. Make sure you are running VPN connection
5. Check you list the buckets in the COS instance
    ```
    aws s3 --endpoint-url=https://s3.us-south.cloud-object-storage.appdomain.cloud  ls
    ```
5. Delete the contents of the bucket recursively using this CLI command, Make sure you are using the correct COS Endpoint
    ```
    aws s3 --endpoint-url=https://s3.us-south.cloud-object-storage.appdomain.cloud  ls s3://temenos-workload-flow-logs --recursive
    ```
6. This will delete the entire content of the COS bucket




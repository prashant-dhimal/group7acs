# group7acs
#Hello Professor Welcome to ACSFINAL Project. 
# This Project is based on Implementation of Two-Tiered Web Application with the help of Terraform Automation
# Short Description of Project
Project is based on Implelentation of two-tier web application, from Terraform, which is scalable, and highly available, webservers are expanded on three availability zone, on same region, and has feature of both scale out and scale in, in order to evenly maintain the flow of traffic, we have introduced Application Load Balancer as well. All the Webserver are on private subnets, which isolate them from the public network, and we have implemented NAT Gateway for private subnets, which will ensure that the web instances on private subnets can reach out to internet for various updates and downloading of various required packages. Bastion Host is also introduced, which allows us to connect(SSH) the EC2 instances on private subnets for various troubleshoot the EC2 instances. We have introduces security group on three levels, one on ALB, next one for Bastion Host and next one for EC2 Instances. For Two-Tier Webapplication, we used S3 Bucket to store the remote state imformation, which can be used for the implementation of webserver. We have used auto launch configuration which can be user for scaling out .There are three environment mainly dev, staging and prod. We have used tflint for the scanning of terraform code, which will check for the integrity of code. We used terraform modules, for grouping the resources together and reusing the code again. 

# Prerequisite of Starting the Project on Terraform
**Setting up Environment**
We can use EC2 Instances(Linux or Ubuntu) or Use of CLoud9 for the project. I would recommend use of cloud9,as it includes all the tools used for this project such as terraform and github.

 **Creation of four S3 Bucket on AWS Account, bucket names must be unique**
* group7acs-dev
* group7acs-staging
* grou7acs-prod
* group7acsstaticwebsite-dev
* group7acsstaticwebsite-staging
* group7acsstaticwebsite-prod

#To use s3 bucket as the backend create folder into each of the bucket, as for my terraform module for dev environment, create a folder names as,  group7acs-dev and inside group7acs-dev folder create network and webserver folder.
#for staging bucket create network and webserver bucket inside group7acs-staging folder.
#for prod bucket create network and webserver bucket inside group7acs-prod folder


group7acsstaticwebsite bucket is used to fetch the images on the website, so for dev upload any image with the name dev or any other naming conventions, if used any name instead of dev, change the name of image name under aws_launch_configuration module, install_httpd_webserver.sh.tpl. Similarly for Prod for Staging you can use same image or use different image and as mentioned above changing of image name is necessary,if you are planning to use the different image. 


If using the Learner Lab, you can attach IAM role EMR_EC2_Deafult_Role, to the instances this role allows many actions to be perfomed, among them the access to S3 bucket is also given, which will allow us to fetch the images from S3 bucket for website.

If using Personal or Organization AWS account  you need to create a IAM Role for EC2 Instance to access the bucket and attach the role to the instance


Creation of Bucket Policy and Assiging the Permission to GetObject from the bucket

```
{
    "Statement": [
        {
            "Action": [
                 "s3:GetObject",
                 "s3:ListBucket",
           
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::group7acsstaticwebsite/*"
            ],
            "Sid": "VisualEditor0"
        }
    ],
    "Version": "2012-10-17"
}

```


**Note: Changing the image name inside the code is only possible after you have cloned codes the github repository.**

After completion of above steps, its time for the clonning part, use the below command to clone repo.
```
$ git clone https://github.com/prashant-dhimal/group7acs.git

```
Creation of ssh_keys
* For this Project we need to create three ssh_keys, namely ssh_key_dev, ssh_key_staging and ssh_key_prod, for your convenience, you can use the webserver folder inside the environment to store the ssh keys.

command to create ssh_keys
 ```
 $ ssh-keygen -t rsa -f ~/.ssh/ssh_key_dev
 
 ```

## The Prequisites are over, we are almost ready with the the deployment.
**For environment Dev**

Navigate inside environment folder and go inside dev folder and inside dev folder navigate inside the network folder then on your terminal type the follow command
If you are faimiliar with Alias, you can create alias of terraform to tf, command is 
```
alias  tf=terraform

```
* The direcroty structure is 
* $ **group7acs/environments/dev/network**


Run the following command inside dev
```
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply --auto-approve

```
The above command will deply VPC, Subnets both Private and Public, Internet Gateway, Elastic IP needed for NAT Gateway, Route Tables and print the output of vpc id and both private and public subnets ids. All of these data are saved inside the group7acs-dev bucket under, group7acs-dev/group7-acs/dev/network/terraform.tfstate

#After deploying Networking Part, navigate to webserver folder inside dev environment
the folder structure is 
* $**group7acs/environments/dev/webserver**


Run the following command inside dev
```

$ terraform init
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply --auto-approve
```

The above command will create the Bastion Host, Launch Configuration, AutoScaling, EC2 Instances, by using the launch configuration, Target Group, Load Balancer and the ALB DNS Name is printed as output on the screen, we need to copy the ALB-DNS name and paste on Web Browser.

#After Deploying the terraform its time to destroy the infrastructure.

#Inside the webserver folder of dev environment, run the command
```
$ terraform destroy --auto-approve

```


After the webserver infrastructure are destroyed, its time to destroy the network infrastructure.
navigate inside the network folder inside the environments, rum the following command
```
$ terraform destroy --auto-approve  

```

## For other Environments, please repeat the above steps, starting the Dev Environment Section.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Thank You, Happy Coding!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



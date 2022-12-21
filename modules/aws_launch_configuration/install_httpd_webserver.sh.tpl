#!/bin/bash
 yum -y update
 yum -y install httpd
 sudo aws s3 cp s3://group7acsstaticwebsite/s3_1.jpg  /var/www/html/image
 myip=`hostname -I`
 echo "<h1>Welcome to ${prefix} ${app}! private IP is $myip in ${env} environment </h1> <h2> Name: ${owner} and  StudentID: ${studentId} </h2><br>Built by Terraform! </br>"  >  /var/www/html/index.html
 echo " <img src='image'/>" >>  /var/www/html/index.html
 sudo systemctl start httpd
 sudo systemctl enable httpd
# Default tags for output
output "default_tags" {
  value = {
    "Owner" = "Prashant, Prince , Subham"
    "App"   = "ACS730 Final Project"
    "StudentId"="171162217,xxxx,xxxxxx"
  }
}

# Prefix to identify the Group For the Project
output "prefix" {
  value     = "Group7"
}

#output of public ip
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

output "public_ip" {
  value = ["${chomp(data.http.myip.body)}/32"]
}
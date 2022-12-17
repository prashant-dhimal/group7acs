#Creating IAM ROLE
resource "aws_iam_role" "instance_role" {
  name               = "IAM-Role"
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
   "Statement": [
    {
      "Sid": "",
       "Effect": "Allow",
       "Principal": {
         "Service": "ec2.amazonaws.com"
      },
       "Action": "sts:AssumeRole"
    }
  ]
}

EOF
}
# Creating IAM Policy
/*resource "aws_iam_role_policy" "instance_policy" {
  name        = "IAMPolicy"
  role        = "${aws_iam_role.instance_role}"
  policy      =   <<EOF
    {
     "indented":"true",
     "Version": "2012-10-17",
     "Statement": [
        {
             "Action": [
                 "s3:ListBucket"
            ],
             "Resource": ["arn:aws:s3:::group7acsstaticwebsite/*"]
             "Effect": "Allow"
        },
        {
             "Action": [
                 "s3:GetObject"
            ],
             "Resource": ["arn:aws:s3:::group7acsstaticwebsite/*"]
             "Effect": "Allow"
        }
      ]
  }

 EOF
} */

#Attaching IAM ROLE
resource "aws_iam_instance_profile" "bucketaccessprofile" {
  name = "EC2S3BucketAccess"
  role = aws_iam_role_policy.instance_policy.id
}
resource "aws_iam_role_policy" "instance_policy" {
  name = "test_policy"
  role = "${aws_iam_role.instance_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::group7acsstaticwebsite/*"]
    }
  ]
}
EOF
}
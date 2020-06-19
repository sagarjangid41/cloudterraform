provider "aws" {
  region  = "ap-south-1"
  profile  =  "sagar"
}

resource "aws_security_group" "allow_tls11" {
  name        = "launch-wizard-9"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0d948965"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name =  "allow_tls111" 
  }
}
resource "aws_instance" "web2" {
  ami           = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  key_name      =  "myterra"
  security_groups = [ "launch-wizard-9" ]
  availability_zone = "ap-south-1b"
  tags = {
    Name = "terraform_Instance"
  }
}

resource "aws_ebs_volume" "ebs191" {
  availability_zone = "ap-south-1b"
  size              = 8
  tags = {
    Name = "hard_disk"
  }
}

resource "aws_volume_attachment" "ebs191" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs191.id
  instance_id = aws_instance.web2.id
}


resource "null_resource" "nullremote4"  {

depends_on = [
    aws_instance.web2,
  ]
  connection{

     type = "ssh"
     user = "ec2-user"
     private_key = file("C:/Users/Lenovo/Downloads/myterra.pem")
     host = aws_instance.web2.public_ip
     }

provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
      "sudo git clone https://github.com/sagarjangid41/cloudterraform.git /var/www/html/"
    ]
  }
}

resource "aws_s3_bucket" "examplebucket2dd233" {
  bucket = "terraformbucket12121212"
}
resource "aws_s3_bucket_public_access_block" "examplebucket2d33" {
  bucket = aws_s3_bucket.examplebucket2dd233.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_object" "file_upload" {
key = "image.jpg"
bucket = aws_s3_bucket.examplebucket2dd233.id
source = "C:/Users/Lenovo/Desktop/Untitled Folder/complete/Untitled Folder/datafac/Testing/Testing/Happy/Happy-181.jpg"
acl="public-read"
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Change this to your desired AMI ID
  instance_type = "t2.micro"              # Change this to your desired instance type

  tags = {
    Name = "MyEC2Instance" # Change this to your desired instance name
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y ruby
              yum install -y wget
              cd /home/ec2-user
              wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
              chmod +x ./install
              ./install auto
              service codedeploy-agent start
              EOF
}
# codedeploy.tf

# Create a CodeDeploy application
resource "aws_codedeploy_app" "my_app" {
  name = "my-codedeploy-app" # Change this to your desired application name
}

# Create a CodeDeploy deployment group
resource "aws_codedeploy_deployment_group" "my_deployment_group" {
  app_name              = aws_codedeploy_app.my_app.name
  deployment_group_name = "my-deployment-group" # Change this to your desired deployment group name
  service_role_arn      = aws_iam_role.codepipeline_role.arn

  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = "MyEC2Instance" # Change this to the tag name of your EC2 instance
      type  = "KEY_AND_VALUE"
    }
  }
}
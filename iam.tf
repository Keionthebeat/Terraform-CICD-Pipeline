# Create an IAM role for CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role" # Change this to your desired role name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach a policy to the IAM role to allow necessary actions
resource "aws_iam_role_policy" "codepipeline_policy" {
  role = aws_iam_role.codepipeline_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "codedeploy:*",
          "ec2:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}
# codepipeline.tf

# Create a CodePipeline resource
resource "aws_codepipeline" "my_pipeline" {
  name     = "my-pipeline" # Change this to your desired pipeline name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = "your-github-username/your-repo-name" # Change this to your GitHub username and repository name
        BranchName = "main" # Change this to your desired branch
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      version          = "1"
      input_artifacts  = ["source_output"]
      configuration = {
        ApplicationName     = aws_codedeploy_app.my_app.name
        DeploymentGroupName = aws_codedeploy_deployment_group.my_deployment_group.deployment_group_name
      }
    }
  }
}
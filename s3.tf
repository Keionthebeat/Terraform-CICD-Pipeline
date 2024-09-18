# Create an S3 bucket to store CodePipeline artifacts
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "my-codepipeline-bucket" # Change this to a unique bucket name
}
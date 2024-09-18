# Codestar connection to GitHub

resource "aws_codestarconnections_connection" "github_connection" {
  name = "my-github-connection" # Change this to your desired connection name
  provider_type = "GitHub"
}
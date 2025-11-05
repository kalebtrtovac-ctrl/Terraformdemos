provider "google" {
    project = local.credentials.project_id
    credentials = file("../kaleb-demo-project1-d0679db7957c.json")
  
}

## beta if I want SSL cert
provider "google-beta" {
    project = local.credentials.project_id
  credentials = file("../kaleb-demo-project1-d0679db7957c.json")
}

## local variables to be used everywhere to keep this shit clean
# parses service acct key file
locals {
  credentials = jsondecode(file("../kaleb-demo-project1-d0679db7957c.json"))
  service_account_email = local.credentials.client_email
}
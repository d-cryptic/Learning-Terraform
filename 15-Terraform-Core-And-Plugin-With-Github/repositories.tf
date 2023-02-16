resource "github_repository" "terraform-first-repo" {

  // about description
  name = "first-repo-from-terraform"
  //  description = "My first resource created on github using terraform"
  visibility = "public"

  // readme file
  auto_init = true
}

output "terraform-first-repo-url" {
  value = github_repository.terraform-first-repo.html_url
}

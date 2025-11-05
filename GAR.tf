resource "google_artifact_registry_repository" "Kalebs_repo" {
    provider = google
    project = local.credentials.project_id
    location = "northamerica-northeast1" 
    repository_id = "Kalebs-repository"
    format = "DOCKER"
    
}
  

## output the repo info
output "artifact_registry_docker_repo_path" {
  value       = "${google_artifact_registry_repository.Kalebs_repo.location}-docker.pkg.dev/${local.credentials.project_id}/${google_artifact_registry_repository.Kalebs_repo.repository_id}"
  description = "Base Docker repo path for tagging/pushing images."
}

## cp format above if I need another repo just change name and repo_id
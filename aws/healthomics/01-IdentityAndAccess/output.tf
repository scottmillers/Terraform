output "omics_users_group_name" {
  description = "Group to add the Bioinformatics user"
  value       = aws_iam_group.bioinformatics_group.name
}

output "omics_workflow_role" {
  description = "Service role to run the Omics workflows"
  value       = aws_iam_role.omics_service_role.name
}




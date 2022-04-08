output "snowflake_loader_user" {
  description = "The Snowflake user used by Snowflake Loader"
  value       = module.snowflake_target.snowflake_user
}

output "snowflake_database" {
  description = "Snowflake database name"
  value       = module.snowflake_target.snowflake_database
}

output "snowflake_schema" {
  description = "Snowflake schema name"
  value       = module.snowflake_target.snowflake_schema
}

output "snowflake_loader_role" {
  description = "Snowflake role for loading snowplow data"
  value       = module.snowflake_loader_setup.snowflake_loader_role
}

output "snowflake_warehouse" {
  description = "Snowflake warehouse name"
  value       = module.snowflake_loader_setup.snowflake_warehouse
}

output "snowflake_transformed_stage_name" {
  description = "Name of transformed stage"
  value       = module.snowflake_loader_setup.snowflake_transformed_stage_name
}

A README for preparing Databricks for loading Snowplow data.

Its following *outputs* should be used as input variables of `aws/pipeline`.

* The *JDBC connection details*.
* The *loader access token*.
* The *schema name*.
* The *catalog name*.

## Requirements

* Access to your Databricks workspace console, with permissions to create a cluster and execute SQL.

## Step 1: Create a cluster

This is the *"RDB Loader cluster"*.  We describe two ways of creating this cluster: you can follow the steps for manual setup via Databricks console outlined below or use the suggested terraform code.

The cluster spec described below should be sufficient for a monthly event volume of up to 10 million events. If your event volume is greater then you may need to increase the size fo the cluster.

### Setup via Databricks console

Create a new cluster, following the [Databricks documentation](https://docs.databricks.com/clusters/create.html), with the following settings:

* single node cluster
* "smallest" size node type
* auto-terminate after 30 minutes.

### Setup via Terraform

Here's an example cluster configuration using the [Databricks Terraform provider](https://docs.databricks.com/dev-tools/terraform/index.html):

```terraform
data "databricks_node_type" "smallest" {
  local_disk = true
  category   = "General Purpose"
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "single_node" {
  cluster_name            = "DatabricksLoaderCluster"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 30
  num_workers             = 0

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*, 4]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
}
```

### Advanced cluster configurations (optional)

You might want to configure cluster-level permissions, by following [the Databricks instructions on cluster access control](https://docs.databricks.com/security/access-control/cluster-acl.html).  Snowplow's RDB Loader must be able to restart the cluster if it is terminated.

If you use AWS Glue Data Catalog as your metastore, [follow these Databricks instructions](https://docs.databricks.com/data/metastores/aws-glue-metastore.html) for the relevant spark configurations.  You will need to set `spark.databricks.hive.metastore.glueCatalog.enabled true` and `spark.hadoop.hive.metastore.glue.catalogid <aws-account-id-for-glue-catalog>` in the spark configuration.

You can configure your cluster with [an instance profile](https://docs.databricks.com/administration-guide/cloud-configurations/aws/instance-profiles.html) if it needs extra permissions to access resources.  For example, if the S3 bucket holding the delta lake is in a different AWS account.

## Step 2: Note the JDBC connection details for the cluster

1. In the Databricks UI, click on "Compute" in the sidebar.
2. Click on the *RDB Loader cluster* and navigate to "Advanced options".
3. Click on the "JDBC/ODBC" tab.
4. Note down the JDBC connection URL - specifically the `host`, the `port` and the `http_path`.

These are the *JDBC connection details*.

## Step 3: Create access token for the RDB Loader

**Note**: The access token must not have a specified lifetime. Otherwise, RDB Loader will stop working when the token expires.

1. Navigate to the user settings in your Databricks workspace.  For Databricks hosted on AWS, the "Settings" link is in the lower left corner in the side panel.  For Databricks hosted on Azure, "User Settings" is an option in the drop-down menu in the top right corner.
2. Go to the "Access Tokens" tab.
3. Click the "Generate New Token" button.
4. Optionally enter a description (comment). Leave the expiration period empty.
5. Click the "Generate" button.
6. Copy the generated token and store in a secure location.

This is the *loader access token*.

## Step 4: Create catalog and schema

The SQL to create the required events table for Snowplow data is below.

You can change the name of the schema to be used (the default is `snowplow`) but do not change the name of the `events` table.

The `events` table will be created by RDB Loader when it starts up along with a `manifest` table to record what/when a folder was loaded.

```sql
-- USE CATALOG <custom_unity_catalog>; -- Uncomment if your want to use a custom Unity catalog and replace with your own value.

CREATE SCHEMA IF NOT EXISTS snowplow
-- LOCATION s3://<custom_location>/ -- Uncomment if you want tables created by Snowplow to be located in a non-default bucket or directory.
;
```

# Store a State file in S3

Using Terragrunt my top level directory has a `root.hcl` file.  That file has the following configuration:

```hcl

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${get_env("TG_BUCKET_PREFIX", "")}terragrunt-example-tf-state-${local.account_name}-${local.aws_region}"
    key            = "${path_relative_to_include()}/tf.tfstate"
    region         = local.aws_region
    dynamodb_table = "tf-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

```

This uses an environment variable called `TG_BUCKET_PREFIX` as the prefix to the bucket name.  If the environment variable is not set it will use the default bucket name which will fail since it already exists.
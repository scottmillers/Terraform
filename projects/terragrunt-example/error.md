18:17:56.307 INFO   Downloading Terraform configurations from git::ssh://git@github.com/gruntwork-io/terragrunt-infrastructure-modules-example.git?ref=v0.8.0 into ./.terragrunt-cache/r563FStzoh_StUz-ydYNGw2nq58/9KdFiGzs0Psssz02yWzKhq8EFFM
18:17:56.694 ERROR  downloading source url git::ssh://git@github.com/gruntwork-io/terragrunt-infrastructure-modules-example.git?ref=v0.8.0
error occurred:

* error downloading 'ssh://git@github.com/gruntwork-io/terragrunt-infrastructure-modules-example.git?ref=v0.8.0': /usr/local/bin/git exited with 128: Cloning into './.terragrunt-cache/r563FStzoh_StUz-ydYNGw2nq58/9KdFiGzs0Psssz02yWzKhq8EFFM'...
  git@github.com: Permission denied (publickey).
  fatal: Could not read from remote repository.
  
  Please make sure you have the correct access rights
  and the repository exists.
  

18:17:56.695 ERROR  Unable to determine underlying exit code, so Terragrunt will exit with error code 1
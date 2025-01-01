
#  GitHub SSH key

Terragrunt needs to access modules in Github through SSH.  You to create a SSH key.  If you don't you get errors like this:
```
error downloading 'ssh://git@github.com/gruntwork-io/terragrunt-infrastructure-modules-example.git?ref=v0.8.0': /usr/local/bin/git exited with 128: Cloning into './.terragrunt-cache/r563FStzoh_StUz-ydYNGw2nq58/9KdFiGzs0Psssz02yWzKhq8EFFM'...
  git@github.com: Permission denied (publickey).
```

In this case, it is using `git@github.com` to connect. 



Steps to create a new key:
1. Verify you don't already have [existing GitHub SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)

2. To create a new SSH key replace you email with your GitHub email
    ```
    ssh-keygen -t ed25519 -C "git@github.com"
    ```
3. Start the ssh-agent
    ```
    eval "$(ssh-agent -s)"
    ```

4. Add your SSH private key to the ssh-agent
    ```
    ssh-add ~/.ssh/id_ed25519
    ```

5. Authenticate with GitHub through the CLI
    ```
    gh auth login
    ```

5. Add you SSH public key to your account on GitHub

    ```
    gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication
    ```

6. Verify it works
    ```
    gh repo list
    ```

7. Save your private key


## References
- GitHub ssh agent
https://docs.github.com/en/authentication/connecting-to-github-with-ssh

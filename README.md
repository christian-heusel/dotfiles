# My Dotfiles

1. Install all the Programs
   ```cmd
   # ansible-playbook 00_install.yml
   ```
2. Do some stuff by hand:
    1. Set a password for the newly created user
    2. login as the new user
    3. disable the root password
2. Bootstrap
   ```cmd
   $ ansible-playbook --tags bootstrap 01_configure.yml
   ```
3. Do some things by hand (`ssh-add` etc)
4. Configure the rest (should not need priv. escalation if nothing needs doing!)
   ```cmd
   $ ansible-playbook 01_configure.yml
   ```

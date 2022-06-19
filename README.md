# My Dotfiles

This is not really meant to be used by other people (atleast directly), but feel free to look into my ansible playbooks and roles!

## Notes for future me
We work on a basic install of ArchLinux so far 😊 Debian Testing should work aswell, but thats not as heavily tested ...

0. Install the dependent AUR role
   ```cmd
   # ansible-galaxy install -r requirements.yml
   ```
1. refresh the mirrors (and update):
   ```cmd
   # pacman -Sy
   # pacman -Syu
   ```
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

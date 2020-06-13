# Vagrant

## configure user

** Add user **
`sudo adduser --shell `which zsh` --disabled-password vagrant`

** set as sudoer **
```bash
sudo vi /etc/sudoers
vagrant     ALL=(root) NOPASSWD:ALL

# allow `user` to sudo as vagrant without passwd
user        ALL=(vagrant) NOPASSWD:ALL
```

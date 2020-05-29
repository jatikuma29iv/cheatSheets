# Ubuntu Server Setup

## add users to sudoers
```bash
# add line to /etc/sudoers
<username> ALL=(ALL) NOPASSWD:ALL
```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl zsh tmux

## install homebrew
```bash
#run as normal user
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- Install the Homebrew dependencies if you have sudo access:
  Debian, Ubuntu, etc.
```bash
    sudo apt-get install build-essential
```
```bash
  Fedora, Red Hat, CentOS, etc.
    sudo yum groupinstall 'Development Tools'
```
  See https://docs.brew.sh/linux for more information.
- Configure Homebrew in your /home/jet/.profile by running
```bash
    echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/jet/.profile
```
- Add Homebrew to your PATH
```bash
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```
- We recommend that you install GCC by running:
```bash
    brew install gcc
```

## install fzf
```bash
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

#To use fzf in Vim, add the following line to your .vimrc:
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
```
## install k9s
```bash
brew install derailed/k9s/k9s
```

## install kubens, kubectx
```bash
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# zsh completion
mkdir -p ~/.oh-my-zsh/completions
chmod -R 755 ~/.oh-my-zsh/completions
ln -s /opt/kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
ln -s /opt/kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh
```

## install ksync
ref: [https://github.com/ksync/ksync](https://github.com/ksync/ksync#linuxmacosx)
```bash
# run at root
curl https://ksync.github.io/gimme-that/gimme.sh | bash
```

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

## powerline
### Plugin Installation
```bash
sudo apt-get install python-pip
```
- Per user:
  In terminal run:
  
  ```bash
  pip install --user git+git://github.com/Lokaltog/powerline
  ```
  Add ~/.local/bin to $PATH by modifying ~/.profile with your favourite editor:

  ```bash
  gksudo gedit ~/.profile
  ```
  and adding following lines at the end of it:

  ```bash
  if [ -d "$HOME/.local/bin" ]; then
      PATH="$HOME/.local/bin:$PATH"
  fi
  ```
- System wide:
  In terminal run:

  ```bash
  su -c 'pip install git+git://github.com/Lokaltog/powerline'
  ```
### Usage: (for per user installation)
- Vim statusline:
  Add following to your ~/.vimrc or /etc/vim/vimrc:

  ```bash
  set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

  " Always show statusline
  set laststatus=2

  " Use 256 colours (Use this setting only if your terminal supports 256 colours)
  set t_Co=256
  ```
- Bash prompt:
  Add the following line to your ~/.bashrc or /etc/bash.bashrc:

  ```bash
  if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
      source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
  fi
  ```
- Zsh prompt:
  Add the following line to your ~/.zshrc or /etc/zsh/zshrc:

  ```bash
  if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
      source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
  fi
  ```
- Tmux statusline:
  Add the following line to your ~/.tmux.conf:

  ```bash
  source ~/.local/lib/python2.7/site-packages/powerline/bindings/tmux/powerline.conf
  set-option -g default-terminal "screen-256color"
  ```
  If your terminal supports 256 colours, set TERM environment variable to xterm-256color by modifying ~/.bashrc or /etc/bash.bashrc and adding following line:

  ```bash
  export TERM=xterm-256color
  To check if your terminal supports 256 colours check the documentation of your terminal or google it. Most popular terminals support 256 colours.
  ```

  ref: [How can I install and use powerline plugin?
](https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)

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

## setup prompt
```bash
cd # change to home
mkdir .vim_bak && curl -Lso .vimrc https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/ubuntu-server-setup/.vimrc
curl -Lso .profile https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/ubuntu-server-setup/.profile
curl -Lso .bashrc https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/ubuntu-server-setup/.bashrc
curl -Lso .zshrc https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/ubuntu-server-setup/.zshrc
```

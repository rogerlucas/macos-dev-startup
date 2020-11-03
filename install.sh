#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install homebrew/cask-versions/iterm2-beta

brew install coreutils binutils diffutils gawk gnutls gzip screen tmux watch wget curl gdb gpatch m4 make vim nano file-formula git subversion less openssh perl python rsync svn unzip zsh ffmpeg ed findutils wdiff grep gnu-indent gnu-sed gnu-tar gnu-which fswatch fsevents-tools readline xz lsusb

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

xcode-select --install 2>/dev/null

curl https://pyenv.run | bash

py37_last="${$(pyenv install -l|egrep '^  3\.7.*'|sort -r|grep -v dev | head -1)##*( )}"

pyenv install $py37_last
pyenv virtualenv $py37_last p37
pyenv global $py37_last

sudo chsh -s /usr/local/bin/zsh $USER

cat <<EOF >> ~/.zshrc

export SessionID="\${ITERM_SESSION_ID:0:6}"

export PATH="\$HOME/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
alias venv='pyenv local'

alias lt='ls -lrth'
alias tar=/usr/local/bin/gtar
alias indent=/usr/local/bin/gindent
alias sed=/usr/local/bin/gsed
alias awk=/usr/local/bin/gawk
alias which=/usr/local/bin/gwhich
alias grep='/usr/local/bin/ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias egrep='/usr/local/bin/gegrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias shred=gshred

alias sid='echo \$SessionID'
alias ssh="ssh -o SendEnv=SessionID"

alias scp='scp -C'
alias wget="wget --no-check-certificate"
alias extip='dig +time=1 +short @resolver1.opendns.com myip.opendns.com 2>/dev/null || curl ipinfo.io/ip'
alias brewski='brew update && brew upgrade; brew cleanup --prune=30; brew doctor'
alias ipython='ipython --no-confirm-exit'
alias curl='curl --insecure -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/81.0"'

EOF



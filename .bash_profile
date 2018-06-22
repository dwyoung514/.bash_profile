if [ -d "/usr/local/opt/ruby/bin/" ]; then
  # the way brew installs ruby gems, this must be done to add them to the path
  export PATH="$PATH:/usr/local/opt/ruby/bin/"
fi

if [ -d "$HOME/Library/Android/sdk" ]; then
  # set ANDROID_HOME (provided by Android Studio)
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  # add android cli tools to path (notably adb)
  export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
fi

# scala (manual install from .tgz)
if [ -d "/usr/local/share/scala" ]; then
  export SCALA_HOME="/usr/local/share/scala"
  export PATH="$PATH:$SCALA_HOME/bin"
fi

# personal executables
if [ ! -d "$HOME/bin" ]; then
  mkdir "$HOME/bin"
fi
export PATH="$PATH:$HOME/bin"

# Init jenv, if it's installed
if which jenv > /dev/null; then
  eval "$(jenv init -)" # this unsets $JAVA_HOME
  export JAVA_HOME="$(jenv javahome)"
else
  # set jdk path to whatever MacOS thinks it is
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# common ls aliases
alias ls="ls -G"
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias l1="ls -1"
alias l1a="ls -1a"
alias la1="ls -1a"
alias lla="ls -al"
alias lal="ls -al"
alias cd..="cd .."
alias grep="grep --color=auto"
alias ggrep="ggrep --color=auto"

# cd to the "real" path (no symlinks) of the working directory
exitmatrix () {
  local REAL_DIR="$(greadlink -f .)"
  echo "cd \"$REAL_DIR\""
  cd "$REAL_DIR"
}

# because I can't remember how mac does updatedb
updatedb () {
  sudo /usr/libexec/locate.updatedb
}

# because sometimes make install is too darn sketchy
addtopath () {
  local ARG=""
  for ARG in "$@"; do
      ln -s "$(greadlink -f "$ARG")" "$HOME/bin/$ARG"
  done
}

# set up walmart proxy
set-proxy() {
  export {http,https,ftp}_proxy=http://sysproxy.wal-mart.com:8080
  export no_proxy=localhost,127.0.0.0/8,*.local
}

# clear proxy settings
unset-proxy() {
  unset {http,https,ftp,no}_proxy
}

#reset background
slack-background() {
  sudo rm /Library/Walmart/Announcements/Images/*
  sudo cp /Users/d0y007m/Documents/screensaver/slack.png /Library/Walmart/Announcements/Images/slack.png
}

# show examples of all cowfiles
cowlist() {
  for i in $(cowsay -l); do cowsay -f $i "$i"; done
}

# Kill Android File Transfer; it's hard to kill and can't be configured to not have pop-ups when a device is plugged in.
kill-aft() {
  ps x -o pid -o command | grep '[A]ndroid File Transfer' | sed -E 's/ *([0-9]+).*/\1/' | xargs kill
}

#android
export ANDROID_HOME=/Users/d0y007m/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH

# add SSH key
ssh-add -K ~/.ssh/id_rsa 2>/dev/null

#dtcli aliases
# alias dtCLISetup='sudo pip install virtualenv; cd dtCLIJira; virtualenv --python=$(which python3) env; env/bin/pip install requests; env/bin/pip install requests_toolbelt'
alias dtCLISetup='sudo pip install virtualenv; cd dtCLIJira; virtualenv -p python3 env; env/bin/pip install requests; env/bin/pip install requests_toolbelt' 
alias dtCLIStart='cd ~/dtCLIJira/; source env/bin/activate'
 alias runDTCLI='python dtCLIJira.py'    

#grep the line after search
alias grepa="grep -A 2"

platform='unknown';
if [[ `uname` == 'Darwin' ]]; then
 platform='mac';
 lsc='ls -G';
elif [[ `uname` == 'Linux' ]]; then
 platform='linux';
 lsc='ls --color=always';
fi

# Restore default window size in OS X
r() {
 printf '\e[8;24;80t';
}

lsn() {
 ls -la $1| awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)  *2^(8-i));if(k)printf("%0o ",k);print}';
}

lcd() {
 cd $1; $lsc;
}

ccd() {
 cd $1; clear;
}

clcd() {
 if [[ "$1" != "" ]]; then
  dir="$1";
 else
  dir=`echo ~`;
 fi
 clear; cd "$dir"; $lsc;
}

cls() {
 clcd ./;
}

l() {
 clear;
 $lsc "./$1";
}

gl() {
 head -n "$1" $2|tail -n 1;
}

alias n=clcd;
alias b="n ..";

# yank - filename; will copy the filename only.
yank() {
 if [ -e $1 ]; then
  shyank=`cat $@`;
  echo "$shyank" > ~/.shyank
  if [[ $platform == 'mac' ]]; then
   cat ~/.shyank|pbcopy;
  fi
 else
  if [[ $1 == '-' ]]; then
   shift;
  fi
  if [[ $platform == 'mac' ]]; then
   echo -n "$1"|pbcopy;
  fi
  echo $@ > ~/.shyank;
 fi
}

put() {
 cat ~/.shyank;
}

alias c=yank;

alias less="less -R";

alias ls=$lsc;
export PATH+=":./:~/.bin/";
export FIGNORE=.o;
export EDITOR=vi;

# Only autocomplete directories for cd and its aliases
complete -d cd;
complete -d lcd;
complete -d n;
complete -d clcd;

# Enable error messages and command prompt in ed
#alias ed="cat <(echo 'H') <(echo 'P') -|ed";

# Use git-prompt
source ~/.bin/git-prompt;

# Fancy command prompt
PS1='\[\033[0;32m\]\u: \[\033[1;31m\]\W\[\033[1;35m\]$(__git_ps1)\[\033[1;34m\]\$ \[\033[0m\]';

# Sudo the last command just by typing `s`
alias s='sudo $(history -p !!)';

alias vi=vim;

##
# Your previous /Users/josh.williams/.bash_profile file was backed up as /Users/josh.williams/.bash_profile.macports-saved_2016-04-01_at_09:53:06
##

# MacPorts Installer addition on 2016-04-01_at_09:53:06: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Enable recursive wildcards if supported
setopt() {
 for i in $@; do
  if `shopt -p|grep "$i"`; then
   shopt -s "$i";
  fi
 done
}
setopt globstar dirspell cdspell

echo;
echo '"Any fool can criticize, condemn and complain - and most fools do. But
it takes character and self-control to be understanding and forgiving."

	- Benjamin Franklin';
echo;

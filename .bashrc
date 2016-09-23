# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ "$TERM" == *rxvt* ]]; then
   exec zsh
fi

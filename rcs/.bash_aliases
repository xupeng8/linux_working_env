alias wrt='cd /home/eric/work/cavium^ncg-se.main/trunk/solutions/OpenWRT/trunk/octeontx'
alias work='cd /home/eric/work/'
alias wrtre='cd /home/eric/work/openwrt-release'
alias sdk='cd /home/eric/work/octeontx-sdk'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mu='make uImage > /dev/null'
alias muj='make uImage -j48 > /dev/null'
alias md='make distclean'
alias mmenu='make menuconfig'
alias mc='make clean'
alias ms='make static'
alias mm='make -B'
alias m='make'
alias mj='make -j8'
alias mi='make install'

alias ff='find -name'
alias gg='grep --exclude=tags --exclude=*~ --exclude-dir=.svn -nr'
alias v='vim'

alias sl='svn log'
alias slm='svn log | more'
alias slvm='svn log -v | more'
alias sup='svn up'
alias sur='svn up -r'
alias ss='svn st'
alias ssclean="svn st | awk '{print $2}' | xargs rm -rf"
alias ssq='svn st -q'
alias sd='svn diff --diff-cmd /usr/bin/diff -x -w'
alias sc='svn ci -m'
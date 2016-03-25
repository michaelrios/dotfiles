alias editAliases="vim ~/dotfiles/.bash_aliases && source ~/dotfiles/.bash_aliases"

##### MISC

alias ll='ls -lath'

mkd () {
  mkdir -p "$1" && cd "$1";
}

alias path='echo -e ${PATH//:/\\n}'

httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

##### GIT

alias gs="git status"
alias ga="git add"
alias g.="git add ."
alias gd="git branch -d"
gcom () {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git commit -m "$branch: $1"
}

ggetrem () {
        git co -b $1 $2/$1
}

alias corn='git co release-next'
alias rebase='git rebase release-next'

alias db='composer dumpautoload && art migrate:status && art migrate && art db:seed --class=ProductionSeeder'

alias updateme='git fetch tio && git co master && git pull tio master && ggpush -f && corn && git pull tio release-next && ggpush -f && db && composer dumpautoload && composer install'

alias updatemesimple='git fetch tio && git co master && git pull tio master && ggpush -f && corn && git pull tio release-next && ggpush -f'

makepr () {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  repo=$(printf '%s\n' "${PWD##*/}")
  open "https://github.com/tuitionio/$repo/compare/release-next...michaelrios:$branch?diff=split"
}

alias flex="cd ~/sites/flex395.com"
flextail () {
  flex

  tailLaravelLogs
}

alias tio="cd ~/sites/v3.tuition.io"
tiotail () {
  tio

  tailLaravelLogs 
}

tailLaravelLogs () {
  cd storage/logs

  cd http
  httpLog=http/$(ls | tail -1)
  cd ../console
  consoleLog=console/$(ls | tail -1)
  cd ..

  tail -f $httpLog $consoleLog
}

alias art="php artisan"


##### APACHE

alias apacheVhosts="sudo vim /etc/apache2/extra/httpd-vhosts.conf"
alias apacheHttpd="sudo vim /etc/apache2/httpd.conf"
alias apachePermissions="sudo vim /etc/apache2/users/michael.conf"
alias apacheHosts="sudo vim /etc/hosts"
alias apacheRestart="sudo apachectl restart"
apacheTail () {
  cd /var/log/apache2
  tail -f access_log error_log
}


##### ITERM
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}


##### DOCKER
alias dockerStart="/Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh"

alias dockerUp="cd docker && docker-compose up -d && cd .."
alias dockerStop="cd docker && docker-compose stop && cd .."
alias dockerPull="cd docker && docker-compose pull && cd .."
alias dockerRestart="dockerStop && dockerPull && dockerUp"

dockerssh() {
  if [ $# -eq 0 ]; then
    docker ps | awk '{split($0,a); print a[2]}'
    exit 1
  fi  

  imageId=$(docker ps | grep $1 | awk '{split($0,a); print a[1]}')
  docker exec -it $imageId bash
}





##### APPS
alias phantomjs='~/phantomjs-1.9.2-macosx/bin/phantomjs'




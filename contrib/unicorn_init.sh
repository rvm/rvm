#!/usr/bin/env bash
### BEGIN INIT INFO
# Provides: unicorn
# Required-Start: $all
# Required-Stop: $network $local_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start the unicorns at boot
# Description: Enable at boot time.
### END INIT INFO
 
# This is /etc/init.d/unicorn_init (without .sh)
# init.d script for single or multiple unicorn installations. Expects at least one .conf
# file in /etc/unicorn
#
## A sample /etc/unicorn/my_app.conf
##
## RAILS_ENV=production
## RAILS_ROOT=/var/apps/www/my_app/current
## UNICORN="/usr/local/rvm/bin/<WRAPPED_NAME>" #see rvm wrapper above
#
# This configures a unicorn master for your app at /var/apps/www/my_app/current running in
# production mode. It will read config/unicorn.rb for further set up.
#
# You should ensure different ports or sockets are set in each config/unicorn.rb if
# you are running more than one master concurrently.
#
# If you call this script without any config parameters, it will attempt to run the
# init command for all your unicorn configurations listed in /etc/unicorn/*.conf
#
# /etc/init.d/unicorn start # starts all unicorns
#
# If you specify a particular config, it will only operate on that one
#
# /etc/init.d/unicorn start my_app
 
__sig()
{
  typeset __pid
  [[ -s "$2" ]]       &&
  __pid="$(cat "$2")" &&
  [[ -n "${__pid}" ]] &&
  kill -$1 "${__pid}" >/dev/null ||
  return $?
}
 
sig()
{
  __sig "$1" "$PID" || return $?
}
 
oldsig()
{
  __sig "$1" "$OLD_PID" || return $?
}
 
run()
{
  echo -n "$1 - "
  shift
  if
    "$@"
  then
    echo "OK"
  else
    typeset result=$?
    echo "Failed!" >&2
    return $result
  fi
}
 
setup ()
{
  echo "$RAILS_ROOT: "
  cd $RAILS_ROOT || return $?
 
  export PID=$RAILS_ROOT/tmp/pids/unicorn.pid
  export OLD_PID="$PID.oldbin"
  export RAILS_ENV=production
 
  CMD=( "$UNICORN" -c "${RAILS_ROOT}/config/unicorn.rb" -D )
}
 
cmd_start()
{
  if sig 0
  then echo "Already started"
  else run "Starting" ${CMD[@]} || return $?
  fi
}
 
wait_pid_kill()
{
  typeset __count=$1
  while
    (( __count > 0 )) &&
    sig 0
  do
    : $(( __count-- ))
    sleep 1s
  done
  sig 0 || return $?
}
 
cmd_stop()
{
  run "Stopping" sig QUIT
  if
    wait_pid_kill 5
  then
    run "Force stop" sig TERM
    if wait_pid_kill 3
    then return 1
    fi
  fi
}
 
cmd_restart()
{
  cmd_stop && cmd_start || return $?
}
 
cmd_reload()
{
  run "Reloading" sig USR2 &&
  wait_pid_kill 5 &&
  oldsig QUIT ||
  oldsig TERM ||
  cmd_restart ||
  return $?
}
 
cmd_rotate()
{
  run "Rotate" sig USR1  ||
  cmd_start ||
  return $?
}
 
cmd()
{
  setup || return $?
  case "$1" in
    start|stop|restart|reload|rotate)
      cmd_$1 || return $?
      ;;
    upgrade)
      cmd_reload || return $?
      ;;
    *)
      echo "Usage: $0 <start|stop|restart|reload|upgrade|rotate>" >&2
      return 1
      ;;
  esac
}
 
# either run the start/stop/reload/etc command for every config under /etc/unicorn
# or just do it for a specific one
# $1 contains the start/stop/etc command
# $2 if it exists, should be the specific config we want to act on
start_stop ()
{
  if
    [[ -n "$2" ]]
  then
    . "/etc/unicorn/$2.conf" || return $?
    cmd "$1" || return $?
  else
    for CONFIG in /etc/unicorn/*.conf
    do
      . "$CONFIG" || return $?
      cmd "$1" || return $?
    done
   fi
}
 
start_stop "$@"

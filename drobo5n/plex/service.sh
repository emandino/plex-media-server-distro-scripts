#!/bin/sh
. /etc/service.subr

SCRIPTPATH=`dirname \`realpath $0\``
export LD_LIBRARY_PATH="${SCRIPTPATH}"
export PLEX_MEDIA_SERVER_HOME="${SCRIPTPATH}"
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
export LC_ALL="C"
export LANG="C"
ulimit -s 3000

name="Plex Media Server"
version="--VERSION--"
description="The best solution for your local and online media."

framework_version="2.0"
pidfile=/tmp/DroboApps/plex/pid.txt

start()
{
        # if this file doesn't exist, client connections get some ugly warnings.
        touch /var/log/lastlog

        ${SCRIPTPATH}/Application/Plex\ Media\ Server &
        echo $! > ${pidfile}
}

case "$1" in
        start)
                start_service
                exit $?
                ;;
        stop)
                stop_service
                exit $?
                ;;
        restart)
                stop_service
                sleep 3
                start_service
                exit $?
                ;;
        status)
                cat ${logfile}
                exit $?
                ;;
        *)
                echo "Usage: $0 [start|stop|restart|status]"
                exit 1
                ;;
esac

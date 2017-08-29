#!/bin/sh
#
# Startup script for DB2 
# Find the name of the script
NAME=`basename $0`

start() {
    DB2_START=$"Starting ${NAME} service: "
    sudo su db2inst1 -c '. /home/db2inst1/sqllib/db2profile;/home/db2inst1/sqllib/adm/db2start'
    ret=$? 
    if [ $ret -eq 0 ]
    then
            echo "$DB2_START Success."
    else
            echo "$DB2_START Failed!"
            exit 1
    fi
    echo
}

stop() {
    echo -n $"Stopping ${NAME} service: "
    sudo su db2inst1 -c '. /home/db2inst1/sqllib/db2profile;/home/db2inst1/sqllib/adm/db2stop'
    ret=$?
    if [ $ret -eq 0 ]
    then
            echo "Success."
    else
            echo "Failed!"
            exit 1
    fi
    echo
}

restart() {
    stop
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 1
esac
exit 0

#!/bin/bash

                start() {
                echo "Starting log.io process..."
                /usr/bin/log.io-server &
                /usr/bin/log.io-harvester &
                                         }

                stop() {
                echo "Stopping io-log process..."
                pkill node
                                         }                             

                status() {
                echo "Status io-log process..."
                netstat -tlp | grep node
                                         }

case "$1" in
                start)
start
        ;;
                stop)
stop
        ;;
                status)
status
                ;;
                *)
echo "Usage: start|stop|status"
        ;;
esac

#!/bin/bash
sleep 2
service ssh start
sleep 2
echo "Test3"
nginx -g "daemon off;"
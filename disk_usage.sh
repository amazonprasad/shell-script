#!bin/bash

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
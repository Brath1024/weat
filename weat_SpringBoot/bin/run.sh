#!/bin/sh

sudo nohup java -Xms246m -Xmx500m -jar weat-exec.jar > weatlog.log 2>&1 &
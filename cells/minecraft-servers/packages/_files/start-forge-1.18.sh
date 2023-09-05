#!/bin/sh

UNIX_ARGS=$(echo libraries/net/minecraftforge/forge/*/unix_args.txt)

java $JVM_ARGS @$UNIX_ARGS $SERVER_ARGS

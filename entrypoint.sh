#!/bin/sh

if [ -f /.docker_ran ]; then
  sleep infinity
  exit
fi

touch /.docker_ran

# pass on all arguments to entrypoitnt "as-is"
/patcher/helper.sh "$@"

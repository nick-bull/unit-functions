#!/bin/sh

target=$1

cd $(dirname "$target")
target=$(basename "$target")

max_iterations=1024
iterations=0

# Iterate down a (possible) chain of symlinks
while [ -l "$target" ]
do
    if test ${iterations} -gt ${max_iterations}; then
      echo "./initialise/readlink.sh FATAL: max iterations reached"
      exit 1
    fi

    target=$(readlink "$target")
    cd $(dirname "$target")
    target=$(basename "$target")
done

dir=`pwd -p`
result="$dir/$target"

echo $result

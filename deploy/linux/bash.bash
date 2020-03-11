#!/usr/bin/env bash

ln -ns `ls -d1 $PWD/../../bash/.* | grep -E "^.*\.\w+$"` ~

#!/usr/bin/env bash
set -e # halt script on error

git submodule init
git submodule update

cd universal-pddl-parser
scons
cd ..

scons
scons examples
scons test

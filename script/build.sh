#!/usr/bin/env bash
set -e # halt script on error

scons
scons test

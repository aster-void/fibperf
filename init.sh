#!/usr/bin/env bash

cd `dirname -- $0`

(cd red/nodejs && npm ci)
(cd single/nodejs && npm ci)

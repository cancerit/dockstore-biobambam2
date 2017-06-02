#!/bin/bash

set -eux

apt-get -yq update
apt-get install -yq apt-transport-https
apt-get install -yq --no-install-recommends curl
apt-get install -yq --no-install-recommends build-essential
apt-get install -yq --no-install-recommends libcurl4-openssl-dev
apt-get install -yq autoconf
apt-get install -yq --no-install-recommends libtool
apt-get install -yq --no-install-recommends rsync

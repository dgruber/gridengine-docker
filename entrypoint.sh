#!/bin/bash

cd /opt/sge
./install.sh

source /opt/sge/default/common/settings.sh

exec "$@"

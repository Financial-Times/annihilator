#!/usr/bin/env sh

set -a
set -x
set -e


: ${CONSUL:?}
: ${SLEEP:0}

sleep ${SLEEP}   # Oftentimes we want to defer this until stuff is running

/consul-template -consul=${CONSUL} -template=template/haproxy.cfg.tmpl:/annihilator/haproxy.cfg -once

cat /annihilator/haproxy.cfg

exec haproxy -V -f /annihilator/haproxy.cfg

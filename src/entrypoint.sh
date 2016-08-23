#!/usr/bin/env sh

set -a
set -x
set -e


: ${CONSUL:?}

/consul-template -consul=${CONSUL} -template=template/haproxy.cfg.tmpl:/annihilator/haproxy.cfg -once

exec haproxy -V -f /annihilator/haproxy.cfg

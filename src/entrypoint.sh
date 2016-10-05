#!/usr/bin/env sh

set -a
set -x
set -e


: ${MODE:=router}
: ${SLEEP:1}

sleep ${SLEEP}   # Oftentimes we want to defer this until stuff is running

if [ "${MODE}" == "router" ]; then
    : ${CONSUL:?}
    /consul-template -consul=${CONSUL} -template=template/router/haproxy.cfg.tmpl:/annihilator/haproxy.cfg -once
else
    cp -v template/${MODE}/haproxy.cfg.tmpl /annihilator/haproxy.cfg
fi

cat /annihilator/haproxy.cfg

exec haproxy -V -f /annihilator/haproxy.cfg

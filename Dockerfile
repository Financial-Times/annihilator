FROM alpine
MAINTAINER jspc <james.condron@ft.com>

EXPOSE 80

RUN apk update && \
    apk add haproxy wget && \
    wget --quiet --no-check-certificate https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip && \
    wget --quiet --no-check-certificate https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_SHA256SUMS && \
    # Weirdness in sha256sum? \
    grep -q $(sha256sum consul-template_0.15.0_linux_amd64.zip ) consul-template_0.15.0_SHA256SUMS && \
    unzip consul-template_0.15.0_linux_amd64.zip && \
    apk del wget && \
    rm -rvf /tmp/* && \
    rm -rvf /var/cache/apk/*

COPY src/ /annihilator/
COPY template/ /template/

ENTRYPOINT ["/annihilator/entrypoint.sh"]

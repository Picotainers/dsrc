FROM ubuntu:22.04 AS builder

ARG DSRC_REPO=https://github.com/refresh-bio/DSRC.git
ARG DSRC_REF=v2.0.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        g++ \
        git \
        make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone --depth 1 --branch "${DSRC_REF}" "${DSRC_REPO}" dsrc-src

WORKDIR /tmp/dsrc-src
RUN make -f Makefile.c++11 bin \
    && install -Dm755 /tmp/dsrc-src/bin/dsrc /out/usr/local/bin/dsrc

FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /out/usr/local/bin/dsrc /usr/local/bin/dsrc

RUN printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -euo pipefail' \
    'if [ "$#" -gt 0 ] && [ "$1" = "dsrc" ]; then' \
    '  shift' \
    'fi' \
    'exec /usr/local/bin/dsrc "$@"' \
    > /usr/local/bin/entrypoint \
    && chmod +x /usr/local/bin/entrypoint

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/entrypoint"]

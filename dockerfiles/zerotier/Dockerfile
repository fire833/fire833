
# Copyright (C) 2022  Kendall Tauser
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

FROM docker.io/debian:stable-slim AS builder

## Supports x86_64, x86, arm, and arm64

RUN apt-get update && apt-get install -y curl gnupg
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 0x1657198823e52a61  && \
    echo "deb http://download.zerotier.com/debian/buster buster main" > /etc/apt/sources.list.d/zerotier.list
RUN apt-get update && apt-get install -y zerotier-one=1.8.6

# Get dumb-init in image
RUN apt-get update -y && apt-get install -y wget
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

FROM debian:stable-slim

# LABEL version="1.8.6"

# ZeroTier relies on UDP port 9993
# EXPOSE 9993/udp

RUN mkdir -p /var/lib/zerotier-one
COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="ZeroTier One in a container"
LABEL org.opencontainers.image.source https://github.com/fire833/fire833

# COPY --from=builder /var/lib/zerotier-one/main.sh /main.sh
# RUN chmod 0755 /main.sh

ENTRYPOINT [ "dumb-init", "zerotier-one" ]


# Copyright (C) 2025  Kendall Tauser
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

FROM docker.io/alpine:latest AS builder

# Get dumb-init in image
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

FROM docker.io/alpine:latest

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init

RUN apk add tor

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="Tor Anonymyzing Network"
LABEL org.opencontainers.image.source="https://github.com/fire833/fire833"

ENTRYPOINT [ "dumb-init", "tor" ]

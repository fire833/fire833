
# Copyright (C) 2026 Kendall Tauser
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

FROM docker.io/golang:alpine AS builder

# Get dumb-init in image
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && chmod +x /usr/local/bin/dumb-init

RUN go install github.com/letsencrypt/unbound_exporter@latest

FROM docker.io/alpine:latest

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder /go/bin/unbound_exporter /usr/local/bin/unbound_exporter

USER 1000:1000

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="unbound-exporter - Exporter for Unbound DNS Resolver"
LABEL org.opencontainers.image.source="https://github.com/fire833/fire833"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.commit=${COMMIT}
LABEL org.opencontainers.image.builddate=${DATE}

ENTRYPOINT [ "dumb-init", "unbound_exporter" ]

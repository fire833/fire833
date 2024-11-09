
# Copyright (C) 2024  Kendall Tauser
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

FROM docker.io/golang:1.23.2-bookworm AS builder

# Get dumb-init in image
RUN apt-get update -y && apt-get install -y wget
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init
RUN CGO_ENABLED=0 go install github.com/charmbracelet/soft-serve/cmd/soft@eca5e328ab9674c5fa578778b981f8ae64b9bcd3

FROM docker.io/alpine:latest

RUN apk update && apk add --update git bash openssh && rm -rf /var/cache/apk/*
COPY --from=builder /go/bin/soft /usr/local/bin/soft
COPY --from=builder /usr/local/bin/dumb-init /usr/bin/dumb-init

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="Soft serve git server"
LABEL org.opencontainers.image.source="https://github.com/fire833/fire833"

ENTRYPOINT [ "dumb-init", "soft", "serve" ]

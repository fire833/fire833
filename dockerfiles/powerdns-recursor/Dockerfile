
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

# Get dumb-init in image
RUN apt-get update -y && apt-get install -y wget
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

FROM docker.io/debian:stable-slim

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init

RUN apt-get update -y && apt-get upgrade -y && apt-get install pdns-recursor -y

ENTRYPOINT [ "dumb-init", "pdns_recursor" ]

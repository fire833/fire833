
# Copyright (C) 2023  Kendall Tauser
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

FROM docker.io/ubuntu:latest AS builder

# Get dumb-init in image
RUN apt-get update -y && apt-get install -y git wget cmake g++ gcc libasound2-dev libudev-dev
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /usr/src

RUN git clone https://github.com/wb2osz/direwolf.git

WORKDIR /usr/src/direwolf

RUN mkdir build && cd build && cmake .. && make

FROM docker.io/ubuntu:latest

RUN apt-get update -y && apt-get install -y libasound2-dev

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder /usr/src/direwolf/build/src/direwolf /usr/local/bin/direwolf

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="Direwolf - Software TNC"
LABEL org.opencontainers.image.source="https://github.com/fire833/fire833"

ENTRYPOINT [ "dumb-init", "direwolf" ]

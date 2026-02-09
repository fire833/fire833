
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

FROM docker.io/ubuntu:latest AS builder

WORKDIR /app

RUN apt update && apt install -y wget unzip && wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip && unzip terraria-server-1449.zip && chmod +x 1449/Linux/TerrariaServer.bin.x86_64 && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && chmod +x /usr/local/bin/dumb-init

FROM docker.io/ubuntu:latest

WORKDIR /app

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder /app/1449/Linux/* /app/

ENTRYPOINT ["dumb-init", "/app/TerrariaServer.bin.x86_64"]

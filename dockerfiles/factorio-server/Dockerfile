
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

FROM docker.io/archlinux:latest AS builder

WORKDIR /opt

RUN pacman -Sy --noconfirm wget xz && wget -O factorio.tar.xz https://www.factorio.com/get-download/2.0.72/headless/linux64 && xz -d factorio.tar.xz && tar -xvf factorio.tar && rm factorio.tar && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && chmod +x /usr/local/bin/dumb-init

FROM docker.io/archlinux:latest

WORKDIR /opt

COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder /opt/factorio/* /opt/factorio

ENTRYPOINT ["dumb-init", "/opt/factorio/x64/factorio"]

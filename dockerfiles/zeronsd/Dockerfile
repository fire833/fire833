
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

FROM docker.io/alpine:latest as builder

RUN apk add gcc
RUN apk add libgcc
RUN apk add musl-dev
RUN apk add openssl
RUN apk add openssl-dev
RUN apk add curl

RUN curl -sSL sh.rustup.rs >/usr/local/bin/rustup-dl && chmod +x /usr/local/bin/rustup-dl && /usr/local/bin/rustup-dl -y --default-toolchain stable

ENV PATH=/root/.cargo/bin:${PATH}
RUN . /root/.cargo/env && cargo install zeronsd

FROM docker.io/alpine:latest

RUN apk add openssl ca-certificates libgcc

COPY --from=builder /root/.cargo/bin/zeronsd /bin/zeronsd

ENTRYPOINT ["zeronsd"]

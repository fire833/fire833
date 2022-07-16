
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

FROM debian:10-slim AS builder

ARG VERSION=
ENV NO_LUA_JIT="s390x arm64"

# Reusable layer for base update
RUN apt-get update && apt-get -y dist-upgrade && apt-get clean

# devscripts gives us mk-build-deps (and a lot of other stuff)
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y --no-install-recommends devscripts dpkg-dev equivs git python3-venv wget && apt-get clean

WORKDIR /source/

# Get the source from github
RUN wget https://github.com/PowerDNS/pdns/archive/refs/tags/${VERSION}.tar.gz && tar xvf ${VERSION}.tar.gz && mv pdns-${VERSION}/* . && rm ${VERSION}.tar.gz 

# TODO: control file is not in tarballs at all right now
RUN mk-build-deps -i -t 'apt-get -y -o Debug::pkgProblemResolver=yes --no-install-recommends' builder-support/debian/authoritative/debian-buster/control && \
    apt-get clean

RUN cp builder/helpers/set-configure-ac-version.sh /usr/local/bin

ARG MAKEFLAGS=
ENV MAKEFLAGS ${MAKEFLAGS:--j2}

ARG DOCKER_FAKE_RELEASE=NO
ENV DOCKER_FAKE_RELEASE ${DOCKER_FAKE_RELEASE}

RUN if [ "${DOCKER_FAKE_RELEASE}" = "YES" ]; then \
      BUILDER_VERSION="$(IS_RELEASE=YES BUILDER_MODULES=authoritative ./builder-support/gen-version | sed 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\(\(alpha|beta|rc\)\d\+\)\)?.*/\1/')" set-configure-ac-version.sh;\
    fi && \
    BUILDER_MODULES=authoritative autoreconf -vfi

# simplify repeated -C calls with SUBDIRS?
RUN mkdir /build && \
    LUAVER=$([ -z "${NO_LUA_JIT##*$(dpkg --print-architecture)*}" ] && echo 'lua5.3' || echo 'luajit') && \
    ./configure \
      --with-lua=${LUAVER} \
      --sysconfdir=/etc/powerdns \
      --enable-option-checking=fatal \
      --with-dynmodules='bind geoip gmysql ldap lmdb lua2 pipe remote tinydns' \
      --enable-tools \
      --enable-ixfrdist \
      --with-unixodbc-lib=/usr/lib/$(dpkg-architecture -q DEB_BUILD_GNU_TYPE) && \
    make clean && \
    make $MAKEFLAGS -C ext && make $MAKEFLAGS -C modules && make $MAKEFLAGS -C pdns && \
    make -C pdns install DESTDIR=/build && make -C modules install DESTDIR=/build && make clean && \
    strip /build/usr/local/bin/* /build/usr/local/sbin/* /build/usr/local/lib/pdns/*.so

RUN cd /tmp && mkdir /build/tmp/ && mkdir debian && \
    echo 'Source: docker-deps-for-pdns' > debian/control && \
    dpkg-shlibdeps /build/usr/local/bin/* /build/usr/local/sbin/* /build/usr/local/lib/pdns/*.so && \
    sed 's/^shlibs:Depends=/Depends: /' debian/substvars >> debian/control && \
    equivs-build debian/control && \
    dpkg-deb -I equivs-dummy_1.0_all.deb && cp equivs-dummy_1.0_all.deb /build/tmp/

# Runtime
FROM debian:stable-slim

# Reusable layer for base update - Should be cached from builder
RUN apt-get update && apt-get -y dist-upgrade && apt-get clean

# Ensure python3 and jinja2 is present (for startup script), and sqlite3 (for db schema), and tini (for signal management),
#   and vim (for pdnsutil edit-zone) 
RUN apt-get install -y python3 python3-jinja2 sqlite3 tini libcap2-bin vim-tiny && apt-get clean

# Output from builder
COPY --from=builder /build /
RUN chmod 1777 /tmp # FIXME: better not use /build/tmp for equivs at all

# Ensure dependencies are present
RUN apt-get install -y /tmp/equivs-dummy_1.0_all.deb && apt-get clean

# Start script
COPY dockerdata/startup.py /usr/local/sbin/pdns_server-startup

COPY dockerdata/pdns.conf /etc/powerdns/
RUN mkdir -p /etc/powerdns/pdns.d /var/run/pdns /var/lib/powerdns /etc/powerdns/templates.d

# Work with pdns user - not root
RUN adduser --system --disabled-password --disabled-login --no-create-home --group pdns --uid 953
RUN chown pdns:pdns /var/run/pdns /var/lib/powerdns /etc/powerdns/pdns.d /etc/powerdns/templates.d
USER pdns

# Set up database - this needs to be smarter
RUN sqlite3 /var/lib/powerdns/pdns.sqlite3 < /usr/local/share/doc/pdns/schema.sqlite3.sql

# Default DNS ports
EXPOSE 53/udp
EXPOSE 53/tcp
# Default webserver port
EXPOSE 8081/tcp

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/sbin/pdns_server-startup"]

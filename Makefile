
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

# Tool lookup
BUILDAH         =       $(shell which buildah)
CURL            =       $(shell which curl)
JQ              =       $(shell which jq)

.PHONY: pdns-auth
pdns-auth:
    VERSION=$(shell ${CURL} https://api.github.com/repos/PowerDNS/pdns/releases/latest)

    ${BUILDAH} bud --build-arg VERSION=${VERSION} dockerfiles/powerdns-auth/Dockerfile

.PHONY: pdns-recursor
pdns_recursor:
	VERSION=$(shell ${CURL} https://api.github.com/repos/PowerDNS/pdns/releases/latest)

    ${BUILDAH} bud --build-arg VERSION=${VERSION} dockerfiles/powerdns-recursor/Dockerfile

.PHONY: openvpn
openvpn:
	${BUILDAH} bud --build-arg VERSION=${VERSION} dockerfiles/openvpn/Dockerfile

.PHONY: freeradius
freeradius:
	${BUILDAH} bud --build-arg VERSION=${VERSION} dockerfiles/freeradius/Dockerfile

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

# Tool lookup
BUILDAH         =       $(shell which buildah)

.PHONY: pdns-auth
pdns-auth:
	@echo "Building PDNS Auth image..."
	${BUILDAH} bud --build-arg VERSION=$(shell cat dockerfiles/powerdns-auth/Version | head -1) dockerfiles/powerdns-auth/Dockerfile

.PHONY: pdns-recursor
pdns-recursor:
	@echo "Building PDNS Recursor image..."
	${BUILDAH} bud --build-arg VERSION=$(shell cat dockerfiles/powerdns-recursor/Version | head -1) dockerfiles/powerdns-recursor/Dockerfile

.PHONY: openvpn
openvpn:
	@echo "Building OpenVPN image..."
	${BUILDAH} bud --build-arg VERSION=$(shell cat dockerfiles/openvpn/Version | head -1) dockerfiles/openvpn/Dockerfile

.PHONY: freeradius
freeradius:
	@echo "Building FreeRADIUS image..."
	${BUILDAH} bud --build-arg VERSION=$(shell cat dockerfiles/freeradius/Version | head -1) dockerfiles/freeradius/Dockerfile

.PHONY: zerotier
zerotier:
	@echo "Building ZeroTier image..."
	${BUILDAH} bud --build-arg VERSION=$(shell cat dockerfiles/zerotier/Version | head -1) dockerfiles/zerotier/Dockerfile
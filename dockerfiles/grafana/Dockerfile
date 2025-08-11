
# Copyright (C) 2025  Kendall Tauser
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

FROM docker.io/grafana/grafana:12.0.4-ubuntu

COPY dockerfiles/grafana/entrypoint.sh /entrypoint.sh

LABEL org.opencontainers.image.author="Kendall Tauser"
LABEL org.opencontainers.image.title="Grafana Dashboard server"
LABEL org.opencontainers.image.source="https://github.com/fire833/fire833"

ENTRYPOINT [ "/entrypoint.sh" ]

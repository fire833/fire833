
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

FROM docker.io/ubuntu:latest

RUN apt update && apt install -y wget adduser polkitd-pkla libexpat1

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && chmod +x /usr/local/bin/dumb-init

# Install stuff needed for FAHClient
# To keep down the size of the image, clean out that cache when finished installing packages.
RUN wget https://download.foldingathome.org/releases/public/fah-client/debian-10-64bit/release/fah-client_8.4.9_amd64.deb && \
    dpkg -i --force-depends fah-client_8.4.9_amd64.deb && rm fah-client*.deb && apt-get clean -y && apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* && apt-get autoremove -y

ENTRYPOINT [ "dumb-init", "/usr/bin/FAHClient" ]

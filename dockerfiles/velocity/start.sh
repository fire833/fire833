#!/bin/bash

# Dumb temporary fix since velocity HAS TO HAVE the config file in
# the SAME WORKING DIRECTORY as the entrypoint, no exceptions.

cp $CONFIG_LOCATION /var/mc/data/velocity.toml
echo "Moved configuration file from $CONFIG_LOCATION to /var/mc/data/velocity.toml."

echo "$FORWARDING_SECRET" > forwarding.secret
echo "Loaded forwarding secret into file."

java -Xms512M -Xmx512M -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -jar /opt/velocity*.jar

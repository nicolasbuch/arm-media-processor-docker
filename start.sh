#!/bin/bash

# Activate license
filebot --license /license/filebot.psm

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
#!/usr/bin/env bash

template_file=atom.tpl
config_file=atom.conf
author_config=author.conf
content_file=content.html

. "${config_file}"
. "${author_config}"
CONTENT=$(<"$content_file")  # Read content into var

eval "echo \"$(cat "${template_file}")\"" > out.txt
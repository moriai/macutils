#!/bin/bash

URL=$(echo "$1" | sed -e 's|\\|/|g' -e 's|^//|smb:&|')
open "$URL"

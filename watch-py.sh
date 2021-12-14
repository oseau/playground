#!/bin/bash
fswatch -e ".*" -i ".*/[^.]*\\.py$" -0 . | xargs -0 -n 1 -I {} sh -c "clear && make start && python {} -v && make end"

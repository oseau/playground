#!/bin/bash
fswatch -e ".*" -i ".*/[^.]*\\.go$" -0 . | xargs -0 -n 1 -I {} sh -c "clear && make start && go run {} && make end"

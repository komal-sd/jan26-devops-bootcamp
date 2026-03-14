#!/bin/bash

check_file() {
    if [ -f "test.log" ]; then
        echo "file found"
    else
        echo "file not found"
    fi
}

check_file

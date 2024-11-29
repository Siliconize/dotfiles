#!/bin/bash

scrot -f --select -l 'style=dash,width=1,color=white' -o - | tesseract stdin stdout | xclip -selection clipboard

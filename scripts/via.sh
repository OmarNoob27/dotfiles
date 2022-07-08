#!/bin/bash

read -p "❯❯❯ Enter a text to share with phone via QR code : " text 
qrencode -m 32 -o via_pc.png "${text}"
sxiv $"via_pc.png" 2> /dev/null

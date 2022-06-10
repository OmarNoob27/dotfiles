#!/bin/bash

# Author: Omar 
# Date of Creation: 10/6/2022
# Last Modified: 10/6/2022
# Description: share any text with phone. 
# Usage: share any text or link via QR code.


read -p "❯❯❯ Enter a text to share via QR code : " text
qrencode -o "via_pc" "${text}" 
sxiv $"via_pc"

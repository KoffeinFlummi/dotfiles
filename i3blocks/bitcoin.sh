#!/bin/bash

price=$(curl -q https://api.bitcoinaverage.com/ticker/global/EUR/ | grep last | grep -o [.0-9]*)

echo " $price€"

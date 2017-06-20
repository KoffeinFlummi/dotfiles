#!/bin/bash

price=$(curl -q https://blockchain.info/de/ticker | grep EUR | grep -o [.0-9]* | head -2 | tail -1)

echo " $price€"

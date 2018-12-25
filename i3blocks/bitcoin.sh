#!/bin/bash

#price=$(curl -q https://blockchain.info/de/ticker | grep EUR | grep -o "[0-9]*\.[0-9][0-9]" | head -2 | tail -1)

btc=$(curl eur.rate.sx/btc | grep avg | egrep -o "[0-9]+\.[0-9]*" | head -1)
ltc=$(curl eur.rate.sx/ltc | grep avg | egrep -o "[0-9]+\.[0-9]*" | head -1)

#echo " $price€"
echo " $btc€ L $ltc€"

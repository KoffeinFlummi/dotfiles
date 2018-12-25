#!/bin/bash

btc=$(curl eur.rate.sx/btc | grep avg | egrep -o "[0-9]+\.[0-9]*" | head -1)
ltc=$(curl eur.rate.sx/ltc | grep avg | egrep -o "[0-9]+\.[0-9]*" | head -1)

echo " $btc€ L $ltc€"

#!/bin/bash

myvar=1

while [ $myvar -le 1000000 ]
do
        echo $myvar
        myvar=$(( $myvar +1 ))
done

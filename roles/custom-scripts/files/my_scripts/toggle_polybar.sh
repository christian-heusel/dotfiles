#!/bin/bash
window="Polybar"
#Obtain the id of the chosen window
window_id=$( xdo id -N $window )
if ( xprop -id $window_id | grep -q "Normal"); then
	xdo hide -N $window
else
	xdo show -N $window
fi


## TEST AREA
#echo $window
#echo $window_id

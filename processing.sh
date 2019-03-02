#!/bin/bash

##########################################################
# Author	: Vladislav Lukoshkin
# Email		: lukoshkin@phystech.edu
#---------------------------------------------------------
# Description	: Wrapper over the program written by 
#		  Sergey Rykovanov. The latter program 
# 		  simulates the interaction of intensive 
#		  laser pulse with solid-state targets. 
#		  In particular, the ellipticity of hard
#		  EM radiation reflected at a certain 
#		  angle from a dense plasma surface is 
#		  calculated for a specified spectrum 
#		  region.
#
#		  Intermediate results are collected in
#		  'results' directory. Final results are
#		  in 'stats.csv' file
#---------------------------------------------------------
# Date 		: 01.31.2019
##########################################################

pi=3.14

# define the circle partition (angles of incidence partition)
delta=0.1

# set the frequency range here (spectrum region)
endpoints="\"(2.,5.)\""


echo "phi,mean,maxi,const" > stats.csv

pattern1="Pulse1\.a0 *= *-?[0-9]+\.?[0-9]*[eE]?[+-]?[0-9]*"
pattern2="Pulse2\.a0 *= *-?[0-9]+\.?[0-9]*[eE]?[+-]?[0-9]*"

# change the amplitude of EM wave in the first line below
for const in 0 $(seq -f "%.2f" 0 0.1 10); do
    for phi in $(seq -f "%.2f" 0 $delta `bc <<< "2 * $pi"`); do
	mkdir -p results/res_$const-$phi 2> /dev/null
	cd results/res_$const-$phi
	cp ../../template.sh run.sh
	echo "cd `pwd`" >> run.sh
	Ey=`echo "from math import cos; print($const * cos($phi))" | python`
	Ez=`echo "from math import sin; print($const * sin($phi))" | python`
   	cat ../../polar.ini | sed -r "s/$pattern1/Pulse1.a0=$Ey/g" | 
			   sed -r "s/$pattern2/Pulse2.a0=$Ez/g" > mod_polar.ini
	echo "../../1dpic.e mod_polar.ini" >> run.sh
	echo "python ../../singleton.py $const $phi $endpoints" >> run.sh
	qsub run.sh
	cd ../..
    done
done

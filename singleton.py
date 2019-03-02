#!/usr/bin/python
import sys

from ellipticity import automatic
from keypar import get_stats

const,phi,string = sys.argv[1:]
endpoints = eval(string)

w,ellipticity = automatic()
mean,maxi = get_stats(w,ellipticity,endpoints)

with open("../../stats.csv","a+") as ofile:
    ofile.write("%s,%f,%f,%s\n" % (phi,mean,maxi,const))

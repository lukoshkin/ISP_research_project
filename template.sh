#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l pmem=6000mb
#PBS -l walltime=1:00:00
#PBS -q batch
#PBS -e /home/Vladislav.Lukoshkin/ISP2019/test/error.txt
#PBS -o /home/Vladislav.Lukoshkin/ISP2019/test/output.txt

module load ScriptLang/python


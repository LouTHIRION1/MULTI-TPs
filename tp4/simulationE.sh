#!/bin/bash

# E
./simul.x -ISETS 256 -IWORDS 1  -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES  193355 > ./Stats/E/simul_1.txt 
./simul.x -ISETS 128 -IWORDS 2  -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES 148381 > ./Stats/E/simul_2.txt
./simul.x -ISETS 64  -IWORDS 4  -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES 130274 > ./Stats/E/simul_3.txt
./simul.x -ISETS 32  -IWORDS 8  -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES 124855 > ./Stats/E/simul_4.txt
./simul.x -ISETS 16  -IWORDS 16 -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES 129468 > ./Stats/E/simul_5.txt
./simul.x -ISETS 8   -IWORDS 32 -IWAYS 1 -DSETS 256 -DWORDS 16 -DWAYS 4 -WBUF 8 -STATS 100 -NCYCLES 149237 > ./Stats/E/simul_6.txt
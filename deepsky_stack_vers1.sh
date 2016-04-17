#!/bin/bash
# vim: ts=4 autoindent 

#===============================================================================
#
# Bash script that makes use of the hugin project panotools to stack
# multiple images together, for noise reduction of deep sky shots. 
#
# Copyright 2016 Ziva-Vatra (http://www.ziva-vatra.com, mail: zv@ziva-vatra.com)
#
# Project website: http://www.ziva-vatra.com/index.php?aid=67&id=U29mdHdhcmU=
# Project repo: https://github.com/ZivaVatra/OSDSS
#
#===============================================================================
#
# Licensed under the GNU GPL. Do not remove any information from this header
# (or the header itself). If you have modified this code, feel free to add your
# details below this (and by all means, mail me, I like to see what other people
# have done)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License (version 2)
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#===============================================================================


if [[ $1 == "" ]]; then
        echo "No input specified! Please give list of images to stack"
	echo "Recommended to use tiff for processing..."
        exit -1
fi

UUID=`head -c 8 /dev/urandom | md5sum | cut -d' ' -f 1`
EXTDIR="./deepsky_"$UUID

echo "Using $EXTDIR as output"
if [ ! -d "$EXTDIR" ]; then
    #if DIR does not exist, create
    mkdir -v $EXTDIR
fi


#First, align images
align_image_stack -i -C -p Project_$UUID.pto $@  #-a astroshot_$UUID $@
nona -v -m TIFF_m -o ./astroshot_$UUID  ./Project_$UUID.pto $@
#move them to correct dir
mv -v ./astroshot_$UUID* ./$EXTDIR/

cd $EXTDIR
#time enfuse -v -l 29 -o deepsky_1.tif ./astroshot*.tif
#time enfuse -v -d 16 -l 29  -o deepsky_2.tif ./astroshot*.tif
#time enfuse -v  -l 29  -o deepsky_1.tif ./astroshot*.tif
time enfuse --compression=LZW -v -d 16 -l 29 --entropy-cutoff=95% --entropy-weight=0.4 --gray-projector=luminance -o ../deepsky_stack.tif ./astroshot*.tif
cd ..
rm -rf ./$EXTDIR #No longer needed
rm Project_$UUID.pto 
cp $1 ./non_stack_reference.tif

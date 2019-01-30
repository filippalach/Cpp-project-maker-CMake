#!/bin/bash

path=`pwd`
DIR_EXS=99
NO_ARG=100

cd $path

if [ $# -eq 1 ]
then
	if [ ! -d "$1.cppproject" ]
	then
		mkdir $1.projectcpp
		cd $1.projectcpp
		mkdir build sources headers
		: > CMakeLists.txt
		tree
	else
		echo "Directory name already exists."; echo
		exit $DIR_EXS
	fi 
else
	echo "No arguments - type 1"; echo
	exit $NO_ARG
fi	
exit 0

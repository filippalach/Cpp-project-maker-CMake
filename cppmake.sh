#!/bin/bash

function main(){

  class_exists=45
  dir_exists=46
  
  local OPTIND=1 opt 

  while getopts "ep:h:" opt; do
    case $opt in 
      p) input="$OPTARG"
	 if [ ! -d "$input.pro" ] 
	 then
	   mkdir -p $input.pro/{build,headers,sources}
	   touch $input.pro/CMakeLists.txt
	   touch $input.pro/sources/main.cpp 
	   cd $input.pro
		  printf "cmake_minimum_required(VERSION 2.8.9)" >> CMakeLists.txt
		  printf "\nproject($input)" >> CMakeLists.txt 
		  printf "\ninclude_directories(headers)" >> CMakeLists.txt 
		  printf "\nfile (GLOB SOURCES \"sources/*.cpp\")" >> CMakeLists.txt
		  printf "\nadd_executable($input \${SOURCES})" >> CMakeLists.txt
	   cd sources 
		  printf "#include <iostream>" >> main.cpp
		  printf "\n\nint main(){" >> main.cpp  
		  printf "\n\n\n}" >> main.cpp
	   cd ..; 
	   tree 
	 else
	   printf "This directory name already exists. Choose another name."
	   exit $dir_exists
	 fi
	 ;;
      e) exec bash
	 ;;
      h) input="$OPTARG" 
	 if [ ! -e headers/$input.h ] && [ ! -e sources/$input.cpp ] && [ -d headers ] && [ -d sources ]
	 then
	   cd headers
	   : > $input.h
	   cd ..; cd sources
	   : > $input.cpp
	   printf "#include \"$input.h\"" >> $input.cpp
	 else
	   printf "This class already exists in working project or bad directory."
	   exit $class_exists 
	 fi
	 ;; 
      \?) read_help ;;
    esac
  done
  shift $((OPTIND-1))
}

function read_help(){
  printf "Error: Bad use of parameter"
  printf "Use -p for project making and -h for adding header"
  printf "Add further -e after -p parameter to end in project dir; ex: cppmake.sh -p Dir -e"
}

main $@

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
		  echo "cmake_minimum_required(VERSION 2.8.9)" >> CMakeLists.txt
		  echo "project($input)" >> CMakeLists.txt; echo "" >> CMakeLists.txt
		  echo "include_directories(headers)" >> CMakeLists.txt; echo "" >> CMakeLists.txt 
		  echo "file (GLOB SOURCES \"sources/*.cpp\")" >> CMakeLists.txt; echo "" >> CMakeLists.txt
		  echo "add_executable($input \${SOURCES})" >> CMakeLists.txt
	   cd sources 
		  echo "#include <iostream>" >> main.cpp; echo "" >> main.cpp
		  echo "int main(){" >> main.cpp; echo "" >> main.cpp; echo "" >> main.cpp; echo "}" >> main.cpp
	   cd ..; 
	   tree 
	   #exec bash
	 else
	   echo "This directory name already exists. Choose another name."
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
	   echo "#include \"$input.h\"" >> $input.cpp
	 else
	   echo "This class already exists in working project or bad directory."
	   exit $class_exists 
	 fi
	 ;; 
      \?) read_help ;;
    esac
  done
  shift $((OPTIND-1))
}

function read_help(){
  echo "Error: Bad use of parameter"
  echo "Use -p for project making and -h for adding header"
  echo "Add further -e after -p parameter to end in project dir; ex: cppmake.sh -p Dir -e"
}

main $@

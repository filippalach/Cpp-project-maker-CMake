#!/bin/bash

function main(){

  class_exists=45
  
  local OPTIND=1 opt 

  while getopts "p:h:" opt; do
    case $opt in 
      p) input="$OPTARG"
	 mkdir -p $input.pro/{build,headers,sources}
	 touch $input.pro/CMakeLists.txt
	 touch $input.pro/sources/main.cpp 
	 tree $input.pro
	 ;;
      h) input="$OPTARG" 
	 if [ ! -e headers/$input.h ] && [ ! -e sources/$input.cpp ] && [ -d headers ] && [ -d sources ]
	 then
	   cd headers
	   : > $input.h
	   cd ..; cd sources
	   : > $input.cpp
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
}

main $@

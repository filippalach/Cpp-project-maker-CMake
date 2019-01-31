#!/bin/bash

function main(){
  local OPTIND=1 opt 
  while getopts ":p:h:" opt; do
    case $opt in 
      p) input="$OPTARG"; 
	 mkdir -p $input.pro/{build,headers,sources}
	 touch $input.pro/CMakeLists.txt
	 touch $input.pro/sources/main.cpp 
	 tree $input.pro ;;
	 #set_var ;;
      h) echo "wybrales h";;
      \?) read_help ;;
    esac
  done
  shift $((OPTIND-1))
}

function set_var(){
  var="export $input=`pwd`/$input.pro"
  cd $HOME
  echo $var >> .bashrc 
}

function read_help(){
  echo "Error: Bad use of parameter"
  echo "Use -p for project making and -h for adding header"
}

main $@

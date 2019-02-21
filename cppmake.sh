#!/bin/bash

function main(){

  local class_exists=455
  local pro_exists=466
  local build_nxst=477
  local no_dir=488
  
  local OPTIND=1 opt 

  local cmake="CMakeLists.txt"
  local pchh="pch.h"
  local pchcpp="pch.cpp"
  local main="main.cpp"

  while getopts "ep:h:mbr:" opt; do
    case "$opt" in 
      p) input="$OPTARG"
	 if [ ! -d "$input.pro" ] 
	 then
	   mkdir -p $input.pro/{build,headers,sources}
	   cd "$input.pro"
	   : > "$cmake"
		  printf "cmake_minimum_required(VERSION 2.8.9)" >> "$cmake"
		  printf "\ninclude(~/PrecompiledHeader.cmake)" >> "$cmake"
		  printf "\n\nproject($input)" >> "$cmake"
		  printf "\n\ninclude_directories(headers)" >> "$cmake"
		  printf "\n\nfile (GLOB SOURCES \"sources/*.cpp\")" >> "$cmake"
		  printf "\n\nadd_executable($input \${SOURCES})" >> "$cmake"
		  printf "\nadd_precompiled_header($input headers/pch.h SOURCE_CXX sources/pch.cpp FORCEINCLUDE)" >> "$cmake"
	   cd sources 
	   : > "$main"
 	   : > "$pchcpp"
		  printf "int main(){" >> "$main"
		  printf "\n\n\n}" >> "$main"
		  printf "#include \"pch.h\"" >> "$pchcpp"
	   cd ../headers
	   : > "$pchh"
		  printf "#ifndef PCH_H" >> "$pchh"
		  printf "\n#define PCH_H" >> "$pchh"
		  printf "\n\n#include <iostream>" >> "$pchh"
	 	  printf "\n\n#endif" >> "$pchh"
	   cd ..
	   tree 
	 else
	   printf "This project directory name already exists. Choose another name."
	   exit "$pro_exists"
	 fi
	 ;;

      e) exec bash
	 ;;

      h) input="$OPTARG" 
	 if [ ! -e headers/$input.h ] && [ ! -e sources/$input.cpp ] && [ -d headers ] && [ -d sources ]
	 then
	   cd headers
	   : > $input.h
	   printf "#pragma once" >> $input.h
	   cd ../sources
	   : > $input.cpp
	   printf "#include \"$input.h\"" >> $input.cpp
	 else
	   printf "This class already exists in working project or bad directory."
	   exit "$class_exists"
	 fi
	 ;; 

      m) path=`pwd`
	 relpath=${path%.pro*}
	 cd "$relpath.pro"
	 if [ -d "build" ]
	 then
	   rm -r build/*
	   cd build 
	   cmake ..
	   exec bash
	   exit 0
	 else	
	   printf "The build dir does not exist. Are you in good dir?"
	   exit "$build_nxst"
	 fi
	 ;;

      b) path=`pwd`
	 relpath=${path%.pro*}
	 cd "$relpath.pro"
	 exec bash
	 ;;

      r) input="$OPTARG"
	 path=`pwd`
	 relpath=${path%.pro*}
	 cd $relpath.pro/..
	 if [ -d "$input" ]
	 then
	   rm -rf "$input"
	 else
	   printf "This .pro directory doest not exist"
	   exit "$no_dir"
	 fi
	 exec bash
	 ;;

      \?) read_help ;;
    esac
  done
  shift $((OPTIND-1))
}

function read_help(){
  printf "Error: Bad use of parameter"
  printf "Use -p <name> for project tree making, -h <name> for adding class files, -b to back to main .pro dir"
  printf "-m to build the project, -r <name.pro> to remove the project"
  printf "Add further -e after -p parameter to end in project dir; ex: cppmake.sh -p Dir -e"
}

main $@

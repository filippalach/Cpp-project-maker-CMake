# Cpp-project-maker-CMake
Tool for making directory tree (c++ project directory) and project managing. With options -p to make project, -h to make class files (.h .cpp), -m cleaning build dir and CMaking again (works with *.pro dir), -b for changing to .pro main directory, -r for removing project directory. Comes with CMake like tree.

Dependency: tree tool

On Debian/Ubuntu:

> sudo apt-get install tree

on openSUSE:

> zypper install tree

or on Fedora:

> yum install tree

Dependency: PrecompiledHeader.cmake from https://github.com/larsch/cmake-precompiled-header

PrecompiledHeader.cmake is essential for pch.h concept work in CMake, make sure to put it in ~/ directory, or change path in CMakeLists.txt include(), line 22

Up for further improvements, depending on needs.

# TOOLCHAIN_PREFIX
# Toolchain prefix needed for the compiler and linker.
#
# CC
# Program for compiling C programs.
#
# CXX
# Program for compiling C++ programs.
#
# LD
# Program for linking.
#
# CUSTOM_CC
# If you want to customize the building for C files, you can use CUSTOM_CC variable.
#
# CUSTOM_CXX
# If you want to customize the building for C++ files, you can use CUSTOM_CXX variable.
#
# CUSTOM_LD
# If you want to customize the building for binaries, you can use CUSTOM_LD variable.
#
# EXTRA_OBJS
# Extra object files to link the target
#
# EXTRA_FILES_TO_CLEAN
# Intermediate files created during the build process. These files should be removed while cleaning.
#
# EXCLUDE_C_SRC
# The file needed to be excluded from build
#
# EXCLUDE_CPP_SRC
# The file needed to be excluded from build
#
# CFLAGS
# Extra flags to give to the C compiler.
#
# CXXFLAGS
# Extra flags to give to the C++ compiler.
#
# LDFLAGS
# Extra flags to give to compilers when they are supposed to invoke the linker, ‘ld’, such as -L.
# Libraries (-lfoo) should be added to the LDLIBS variable instead.
#
# LDLIBS
# Library flags or names given to compilers when they are supposed to invoke the linker, ‘ld’.
# LOADLIBES is a deprecated (but still supported) alternative to LDLIBS.
# Non-library linker flags, such as -L, should go in the LDFLAGS variable.

## Toolchain
TOOLCHAIN_PREFIX:=arm-linux-gnueabi-

## Compiler
CC  := gcc
CXX := g++
LD  := ld

## Custom Building
CUSTOM_CC =
CUSTOM_CXX =
CUSTOM_LD =

## Extra files, objects and excluded files
EXTRA_OBJS +=
EXTRA_FILES_TO_CLEAN +=
EXCLUDE_C_SRC +=
EXCLUDE_CPP_SRC +=

## Flags
# Should not override the parameters
CFLAGS +=
CXXFLAGS +=
LDFLAGS +=
LDLIBS +=

## GDB Debugger
GDB:=gdb-multiarch
GDB_PREFIX:=
GDB_PORT:=2345

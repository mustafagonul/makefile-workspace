## Toolchain Prefix
TOOLCHAIN_PREFIX:=arm-linux-gnueabi-

# CC
# Program for compiling C programs; default ‘cc’.
#
# CXX
# Program for compiling C++ programs; default ‘g++’.
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

## Compiler
CC:=gcc
CXX:=g++
LD=:ld
CPPFLAGS:=
CXXFLAGS:=
LDFLAGS:=
LDLIBS:=

## GDB Debugger
GDB:=gdb-multiarch
GDB_PREFIX:=
GDB_PORT:=2345
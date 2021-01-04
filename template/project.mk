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


EXTRA_OBJS :=
EXTRA_FILES_TO_CLEAN :=
EXCLUDE_C_SRC :=
EXCLUDE_CPP_SRC :=

CFLAGS :=
CXXFLAGS :=
LDFLAGS :=
LDLIBS :=


include ../makefile-workspace/project.mk

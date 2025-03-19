PROJNAME := mandy
EXECNAME := $(PROJNAME)

LIBS :=
FLAGS := $(shell cat compile_flags.txt)

EXECDIR :=
SRCDIR := src
LIBDIR :=
INCDIR := $(SRCDIR)

CXX := g++
UNITYFILE := /tmp/.unity.cpp

ifndef EXECDIR
override EXECDIR = .
endif

all: $(EXECDIR)/$(EXECNAME)

$(EXECDIR)/$(EXECNAME): unity
	$(CXX) $(FLAGS) -iquote . $(UNITYFILE) $(addprefix -L,$(LIBDIR)) $(addprefix -l,$(LIBS)) -O3 -o $@

unity:
	@find $(SRCDIR) -type f \( -name "*.cpp" -o -name "*.cc" -o -name "*.c" \) | sed 's/^.*$$/#include "&"/g' > $(UNITYFILE)

clean:
	rm $(UNITYFILE)
	rm $(EXECDIR)/$(EXECNAME)

.PHONY: all unity

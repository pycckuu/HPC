CXX=g++-6.3.0
CXXFLAGS=-std=c++14 -O3 -Wall -Wextra -Wpedantic -pthread

SOURCES:=$(wildcard ls *.cxx)
DEPS:=$(SOURCES:.cxx=.deps)
TARGETS:=$(SOURCES:.cxx=.exe)

.SUFFIXES:
.SUFFIXES: .deps .exe
.PHONY: clean delstar

all: delstar $(TARGETS)

delstar:
	@echo "Deleting *.deps"
	@rm -f -- \*.deps

clean:
	@echo "Cleaning *.deps, *.exe"
	@rm -f $(DEPS)
	@rm -f $(TARGETS)
	@rm -f -- \*.deps

thread-promise.exe: thread-promise.cxx thread-promise.deps
	@echo "Compiling $<"
	@$(CXX) $(CXXFLAGS) -o $@ $<
	@echo "Generating output for $@"
	@echo -e "$$ $(CXX) $(CXXFLAGS)\n$$ ./$@" >$(patsubst %.exe,%-output.txt,$@)
	@echo "c" | ./$@ >>$(patsubst %.exe,%-output.txt,$@) 2>&1
	@echo "$$ ./$@" >>$(patsubst %.exe,%-output.txt,$@)
	@echo "e" | ./$@ >>$(patsubst %.exe,%-output.txt,$@) 2>&1
	@echo "$$" >>$(patsubst %.exe,%-output.txt,$@)

%.exe: %.cxx %.deps
	@echo "Compiling $<"
	@$(CXX) $(CXXFLAGS) -o $@ $<
	@echo "Generating output for $@"
	@echo -e "$$ $(CXX) $(CXXFLAGS)\n$$ ./$@" >$(patsubst %.exe,%-output.txt,$@)
	@./$@ >>$(patsubst %.exe,%-output.txt,$@) 2>&1
	@echo "$$" >>$(patsubst %.exe,%-output.txt,$@)

%.deps: %.cxx
	@echo "Generating dependencies for $< in $@"
	@$(CXX) $(CXXFLAGS) -MM -MF $@ $<

# Include auto-generated dependencies...
-include *.deps


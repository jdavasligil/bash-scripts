#!/bin/bash

# File Directories
mkdir src build
mkdir build/release

# Boilerplate
cat > src/main.c <<- 'EOM'
#include <stdio.h>

int main(int argc, char* argv[]) {
    printf("Hello, world!");
 
    return 0;
}
EOM

# Git Ignore
cat > .gitignore <<- 'EOM'
build/

*.o
*.so
*.s
*.S
EOM

# Make File
cat > Makefile << 'EOM'
# Name of output binary executable
BINARY=bin

# List of code (.c) directories (sep=space)
CODEDIRS=src

# List of include (.h) directories (sep=space)
INCDIRS=./src

# Compiler (gcc/clang)
CC=gcc

# Optimization flags (https://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/Optimize-Options.html)
OPT=-O0

# Encode make rules for .h dependencies
DEPFLAGS=-MP -MD

# Extra flags (https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html)
CFLAGS=-Wall -Wextra -g $(foreach D,$(INCDIRS),-I$(D)) $(OPT) $(DEPFLAGS)

# List all .c files using regex (wildcard) pattern matching.
CFILES=$(foreach D,$(CODEDIRS),$(wildcard $(D)/*.c))

OBJECTS=$(patsubst %.c,%.o,$(CFILES))
DEPFILES=$(patsubst %.c,%.d,$(CFILES))

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^

%.o:%.c
    $(CC) $(CFLAGS) -c -o $@ $<

clean: 
	rm -rf $(BINARY) $(OBJECTS) $(DEPFILES)

pack: clean
	tar zcvf pkg.tgz *

diff:
	$(info Repository status and volume of per-file changes:)
    @git status
    @git diff --stat
EOM

# READ ME
cat > README.md <<- 'EOM'
# Project Title

Simple overview of use/purpose.

## Description

An in-depth paragraph about your project and overview of use.

## Getting Started

### Dependencies

* Describe any prerequisites, libraries, OS version, etc., needed before installing program.

### Installing

* How/where to download your program
* Any modifications needed to be made to files/folders

### Executing program

* How to run the program
* Step-by-step bullets
```
code blocks for commands
```

## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Jaedin Davasligil
[contact](jdavasligil.swimming625@slmails.com)

## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change]() or See [release history]()
* 0.1
    * Initial Release

## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details

## Acknowledgments

* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [pitchfork](https://api.csswg.org/bikeshed/?force=1&url=https://raw.githubusercontent.com/vector-of-bool/pitchfork/develop/data/spec.bs)
EOM

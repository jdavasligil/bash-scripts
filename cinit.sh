#!/bin/bash

# File Directories
mkdir src build
mkdir build/release

# Boilerplate
cat > src/main.c <<- EOM
#include <stdio.h>

int main(int argc, char* argv[]) {
    printf("Hello, world!");
 
    return 0;
}
EOM

# Git Ignore
cat > .gitignore <<- EOM
build/

*.o
*.so
*.s
*.S
EOM

# Make File
cat > Makefile << EOM
main: main.o
	gcc build/main.o -o build/main.exe
main.o: src/main.c
	gcc -c main.c -o build/main.o
clean: 
	rm build/*.o \
       build/*.so \
       build/*.s \
       build/*.S \
       build/*.exe
       build/release/*.o \
       build/release/*.so \
       build/release/*.s \
       build/release/*.S \
       build/release/*.exe
EOM

# READ ME
cat > README.md <<- EOM
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

# Usage

The Toolchain currently assumes the RIOT directory is installed in `$HOME`

```
git clone https://github.com/astralien3000/cmake2riot.git
cd cmake2riot
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake2riot.cmake
make
make DESTDIR=../install install
```

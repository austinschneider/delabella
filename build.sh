
OPT="-std=c++17 -O3"

if [ -d "delaunator" ]; then
    OPT="$OPT -DDELAUNATOR"
fi

g++ $OPT delabella.cpp delabella-sdl2.cpp -lSDL2 -lGL -o delabella-sdl2

if [ -d "crude-xa" ]; then
    g++ $OPT delabella.cpp delabella-sdl2.cpp crude-xa/src/crude-xa.c -lSDL2 -lGL -o delabella-xa-sdl2
fi

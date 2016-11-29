#!/bin/bash
LD_LIBRARY_PATH="@ESDL_ROOT@/priv"
LD_PRELOAD=/usr/lib64/libSDL-1.2.so.0
export LD_LIBRARY_PATH
export LD_PRELOAD
exec erl -smp disable -noshell -pa "@ESDL_ROOT@"/ebin -pa "@WINGS_ROOT@"/ebin -run wings_start start_halt ${1+"$@"}

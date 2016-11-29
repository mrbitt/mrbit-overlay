#!/bin/bash
exec erl -smp disable -noshell -pa "@ESDL_ROOT@"/ebin "@WINGS_ROOT@"/ebin -run wings_start start_halt ${1+"$@"}

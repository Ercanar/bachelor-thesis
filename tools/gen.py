#!/usr/bin/env python3
from itertools import product

variants = ["1", "2"]
albedo   = ["a_surf"]
vapor    = ["q1", "e_vapor", "dq_eva", "dq_rain"]
extract  = albedo + vapor
state    = [
#    type      name             size     access
    ["float" , "cap_surf"     , "[XY]" , ""],
    ["float" , "ts0"          , "[XY]" , ""],
    ["float" , "ts1"          , "[XY]" , ""],
    ["float" , "ta0"          , "[XY]" , ""],
    ["float" , "ta1"          , "[XY]" , ""],
    ["float" , "to0"          , "[XY]" , ""],
    ["float" , "to1"          , "[XY]" , ""],
    ["float" , "q0"           , "[XY]" , ""],
    ["float" , "q1"           , "[XY]" , ""],
    ["float" , "a_surf"       , "[XY]" , ""],
    ["float" , "e_vapor"      , "[XY]" , ""],
    ["float" , "dq_eva"       , "[XY]" , ""],
    ["float" , "dq_rain"      , "[XY]" , ""],

    ["float" , "tsmn"         , "[XY]" , ""],
    ["float" , "tamn"         , "[XY]" , ""],
    ["float" , "qmn"          , "[XY]" , ""],
    ["float" , "swmn"         , "[XY]" , ""],
    ["float" , "lwmn"         , "[XY]" , ""],
    ["float" , "qlatmn"       , "[XY]" , ""],
    ["float" , "qsensmn"      , "[XY]" , ""],
    ["float" , "ftmn"         , "[XY]" , ""],
    ["float" , "fqmn"         , "[XY]" , ""],
    ["float" , "icmn"         , "[XY]" , ""],
    ["float" , "tomn"         , "[XY]" , ""],

    ["float" , "tmm"          , "[XY]" , ""],
    ["float" , "tamm"         , "[XY]" , ""],
    ["float" , "tomm"         , "[XY]" , ""],
    ["float" , "qmm"          , "[XY]" , ""],
    ["float" , "icmm"         , "[XY]" , ""],

    ["float", "tmn_ctrl"      , "[XY*12]", ""],
    ["float", "tamn_ctrl"     , "[XY*12]", ""],
    ["float", "tomn_ctrl"     , "[XY*12]", ""],
    ["float", "qmn_ctrl"      , "[XY*12]", ""],
    ["float", "icmn_ctrl"     , "[XY*12]", ""],

    ["float" , "z_topo"       , "[XY]" , ""],
    ["float" , "glacier"      , "[XY]" , ""],
    ["float" , "z_ocean"      , "[XY]" , ""],

    ["float" , "tclim"        , "[XY*730]" , ""],
    ["float" , "uclim"        , "[XY*730]" , ""],
    ["float" , "vclim"        , "[XY*730]" , ""],
    ["float" , "qclim"        , "[XY*730]" , ""],
    ["float" , "mldclim"      , "[XY*730]" , ""],
    ["float" , "toclim"       , "[XY*730]" , ""],
    ["float" , "cldclim"      , "[XY*730]" , ""],
    ["float" , "tf_correct"   , "[XY*730]" , ""],
    ["float" , "qf_correct"   , "[XY*730]" , ""],
    ["float" , "tof_correct"  , "[XY*730]" , ""],
    ["float" , "swetclim"     , "[XY*730]" , ""],
    ["float" , "dtrad"        , "[XY*730]" , ""],

    ["float" , "sw_solar"     , "[YDIM*730]" , ""],
    ["float" , "sw_solar_ctrl", "[YDIM*730]" , ""],
    ["float" , "sw_solar_scnr", "[YDIM*730]" , ""],

    ["float" , "co2_part"     , "[XY]" , ""],
    ["float" , "co2_part_scn" , "[XY]" , ""],

    ["float" , "wz_air"       , "[XY]" , ""],
    ["float" , "wz_vapor"     , "[XY]" , ""],

    ["float" , "uclim_m"      , "[XY*730]" , ""],
    ["float" , "uclim_p"      , "[XY*730]" , ""],
    ["float" , "vclim_m"      , "[XY*730]" , ""],
    ["float" , "vclim_p"      , "[XY*730]" , ""],

    ["float" , "year"         , ""     , "&"],
    ["float" , "co2"          , ""     , "&"],
    ["int"   , "mon"          , ""     , "&"],
    ["int"   , "jday"         , ""     , "&"],
    ["int"   , "ityr"         , ""     , "&"],
    ["bool"  , "inject_q1"      , ""     , "&"],
    ["bool"  , "inject_a_surf"  , ""     , "&"],
    ["bool"  , "inject_e_vapor" , ""     , "&"],
    ["bool"  , "inject_dq_eva"  , ""     , "&"],
    ["bool"  , "inject_dq_rain" , ""     , "&"],

]

print("""
#include "preamble.h"
""")

state_struct = ""
save_func    = ""
load_func    = ""

for (v, e) in product(variants, extract):
    n = f"{e}_{v}"
    print(f"FILE* {n} = NULL;")
    state_struct += f"long {n}_off;\n"
    save_func    += f"state->{n}_off = ftell({n});\n"
    load_func    += f"fseek({n}, state->{n}_off, SEEK_SET);\n"

for s in state:
    print(f"extern {s[0]} __mo_state_MOD_{s[1]} {s[2]};")
    state_struct += f"{s[0]} {s[1]} {s[2]};\n"
    save_func    += f"memcpy({s[3]} state->{s[1]}, {s[3]} __mo_state_MOD_{s[1]}, sizeof(state->{s[1]}));\n"
    load_func    += f"memcpy({s[3]} __mo_state_MOD_{s[1]}, {s[3]} state->{s[1]}, sizeof(state->{s[1]}));\n"

print("typedef struct {\n", state_struct, "} State;")
print("static void save(State* state) {\n", save_func, "}")
print("static void load(State* state) {\n", load_func, "}")

print("static void init_files(const char* mode) {")
for (v, e) in product(variants, extract):
    f = f"{e}_{v}"
    print(f'if(({f} = fopen("../extractions/{v}_{e}.save.bin", mode)) == NULL) die("fopen {f} as %s", mode);')
print("}")

for mode in ["inject", "extract"]:
    print(f"static void {mode}_all_albedo(int how) {{")
    print(f"  {mode}_albedo = how;")
    if mode == "inject":
        for x in albedo:
            print(f"  __mo_state_MOD_inject_{x} = how;")
    print("}")

    print(f"static void {mode}_all_vapor(int how) {{")
    print(f"  {mode}_vapor = how;")
    if mode == "inject":
        for x in vapor:
            print(f"  __mo_state_MOD_inject_{x} = how;")
    print("}")

    print(f"static void {mode}_all(int how) {{")
    print(f"  {mode}_all_albedo(how);")
    print(f"  {mode}_all_vapor(how);")
    print("}")

print("void hook_(void) {")
for v in variants:

    #### inject #####

    print(f"  if(inject_albedo == {v}) {{")
    for x in albedo:
        f = f"{x}_{v}"
        n = f"__mo_state_MOD_{x}"
        print(f'    if(fread({n}, ITM({n}), LEN({n}), {f}) != LEN({n})) die("fread {f}");')
    print( "  }")

    print(f"  if(inject_vapor == {v}) {{")
    for x in vapor:
        f = f"{x}_{v}"
        n = f"__mo_state_MOD_{x}"
        print(f'    if(fread({n}, ITM({n}), LEN({n}), {f}) != LEN({n})) die("fread {f}");')
    print( "  }")

    ##### extract #####

    print(f"  if(extract_albedo == {v}) {{")
    for x in albedo:
        f = f"{x}_{v}"
        n = f"__mo_state_MOD_{x}"
        print(f'    if(fwrite({n}, ITM({n}), LEN({n}), {f}) != LEN({n})) die("fwrite {f}");')
    print( "  }")

    print(f"  if(extract_vapor == {v}) {{")
    for x in vapor:
        f = f"{x}_{v}"
        n = f"__mo_state_MOD_{x}"
        print(f'    if(fwrite({n}, ITM({n}), LEN({n}), {f}) != LEN({n})) die("fwrite {f}");')
    print( "  }")
print("}")


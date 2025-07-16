#include <err.h>
#include <libgen.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define ITM(x) (sizeof(x[0]))
#define LEN(x) (sizeof(x)) / ITM(x)

#define XDIM 96
#define YDIM 48
#define XY (XDIM * YDIM)

#define die(...) err(1, __VA_ARGS__)

int inject_albedo = 0;
int inject_vapor  = 0;

int extract_albedo = 0;
int extract_vapor  = 0;

extern int32_t __mo_physics_MOD_log_exp;
extern int32_t __mo_numerics_MOD_time_scnr;

extern void init_shell_(void);
extern void init_model_(void);
extern void greb_model_(void);

void goto_work(void) {
	char* self = realpath("/proc/self/exe", NULL);
	if(chdir(dirname(self))  < 0) die("goto self");
	if(chdir("../mscm/work") < 0) die("goto work");
	free(self);
}

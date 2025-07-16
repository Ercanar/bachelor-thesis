#include <dlfcn.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

static int (*original_open)(const char* path, int flags, ...) = NULL;

static void __attribute__((constructor)) libInit(void);

static void libInit(void) {
	original_open = dlsym(RTLD_NEXT, "open");
	if(original_open == NULL) err(1, "dlsym open failed");
}

int open(const char* path, int flags, ...) {
	printf("opening '%s'", path);

	int extra = 0;
	if(strcmp(path, "scenario.bin") == 0) {
		extra = O_TRUNC;
		printf(", \e[1;33mtruncating!!!\e[m");
	}
	puts("");

	return original_open(path, flags | extra, 0666);
}

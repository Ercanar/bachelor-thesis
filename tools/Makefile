CFLAGS  := -fopenmp -pedantic -O3 -march=native -ffast-math -funroll-loops -Wall -Wextra -Wno-unused-function
LDFLAGS := -fopenmp -lgfortran -lm

BINS := mkExtractions mkSpinup doRuns godawful_hack.so
OBJS := greb.model.mscm.o greb.shell.mscm.o

all: $(BINS)

greb.shell.mscm.o: greb.model.mscm.o

.SUFFIXES:

%: %.o $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@

%.o: %.c decls.h
	$(CC) $(CFLAGS) -c $< -o $@

%.o: ../mscm/%.f90
	$(CC) $(CFLAGS) -Wno-compare-reals -Wno-conversion -c $< -o $@

%.so: %.c
	$(CC) $(CFLAGS) -Wno-pedantic -fPIC -shared $< -o $@

decls.h: gen.py preamble.h
	./$< > $@

clean:
	rm -fv *.o *.mod decls.h $(BINS)
.PHONY: clean

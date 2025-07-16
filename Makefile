REPO := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
RUN  := env LD_PRELOAD=$(REPO)/tools/godawful_hack.so $(REPO)/tools

all:
	make -C $(REPO) extractions
	make -C $(REPO) spinup
	make -C $(REPO) runs

tools:
	make -C $(REPO)/tools -j $(nproc)
.PHONY: tools

extractions: tools
	$(RUN)/mkExtractions
.PHONY: extractions

spinup: tools
	$(RUN)/mkSpinup
.PHONY: spinup

runs: tools
	$(RUN)/doRuns
.PHONY: runs

clean:
	make -C $(REPO)/tools clean
.PHONY: clean

#define _GNU_SOURCE
#include "decls.h"

State s0 = {0};

int main(void) {
	goto_work();
	init_files("w");
	init_shell_();
	init_model_();

	// do a pre-industrial steady-state run
	__mo_physics_MOD_log_exp = 1;
	__mo_numerics_MOD_time_scnr = 50;
	greb_model_();

	save(&s0);

	for(int co2 = 1; co2 <= 2; co2++) {
		__mo_physics_MOD_log_exp = co2 == 1 ? 1 : 10;
		__mo_numerics_MOD_time_scnr = 75;

		load(&s0);

		extract_all(co2);
		greb_model_();

		char* name = NULL;
		asprintf(&name, "../extractions/X%d.bin", co2);

		if(rename("scenario.bin", name) < 0)
			die("move to %s", name);
		free(name);
	}

	return EXIT_SUCCESS;
}

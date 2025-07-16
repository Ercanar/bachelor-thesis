#include "decls.h"

State s0 = {0};

int main(void) {
	goto_work();
	init_files("r");
	init_shell_();
	init_model_();

	// do a pre-industrial steady-state run
	__mo_physics_MOD_log_exp = 1;
	__mo_numerics_MOD_time_scnr = 50;
	greb_model_();

	// inject 1×CO2 and lock all feedbacks
	__mo_numerics_MOD_time_scnr = 15;
	inject_all(1);
	greb_model_();

	save(&s0);

	FILE* state = fopen("../spinup-state.bin", "w");
	if(state == NULL) die("fopen spinup-state.bin");
	if(fwrite(&s0, sizeof(s0), 1, state) != 1) die("fwrite spinup-state.bin");
	fclose(state);

	if(rename("scenario.bin", "../spinup-run.bin") < 0)
		die("save spinup-run.bin");

	return EXIT_SUCCESS;
}

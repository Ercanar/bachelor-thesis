#define _GNU_SOURCE
#include "decls.h"

#define STATE "spinup-state.bin"

extern void auf_wolke_sieben_(void);
float cldclim_orig[LEN(__mo_state_MOD_cldclim)] = {0};

State s0 = {0};

int main(void) {
	goto_work();
	init_files("r");
	init_shell_();

	memcpy(cldclim_orig, __mo_state_MOD_cldclim, sizeof(cldclim_orig));

	init_model_();

	FILE* state = fopen("../" STATE, "r");
	if(state == NULL) die("fopen " STATE);
	if(fread(&s0, sizeof(s0), 1, state) != 1) die("fread " STATE);
	fclose(state);

	int counter = 0;
	for(int co2 = 1; co2 <= 2; co2++) {
		__mo_physics_MOD_log_exp = co2 == 1 ? 1 : 10;

		for(int albedo = 0; albedo <= 2; albedo++) {
			for(int vapor = 0; vapor <= 2; vapor++) {
				for(int clouds = 1; clouds <= 2; clouds++) {
					counter++;
					printf("CO2: %dx, albedo: %d, vapor: %d, clouds: %d (%d of %d)\n",
						co2, albedo, vapor, clouds, counter, 2 * 3 * 3 * 2);

					__mo_numerics_MOD_time_scnr = 50;

					load(&s0);
					inject_all_albedo(albedo);
					inject_all_vapor(vapor);

					if(clouds == 2) {
						auf_wolke_sieben_();
					} else {
						memcpy(__mo_state_MOD_cldclim, cldclim_orig, sizeof(cldclim_orig));
					}

					greb_model_();

					char* name = NULL;
					asprintf(&name, "../runs/X%d-A%d-V%d-C%d.bin",
						co2, albedo, vapor, clouds);

					printf("saving to %s...\n", name);
					if(rename("scenario.bin", name) < 0)
						die("move to %s", name);
					free(name);
				}
			}
		}
	}
}


#include "preamble.h"

FILE* a_surf_1 = NULL;
FILE* q1_1 = NULL;
FILE* e_vapor_1 = NULL;
FILE* dq_eva_1 = NULL;
FILE* dq_rain_1 = NULL;
FILE* a_surf_2 = NULL;
FILE* q1_2 = NULL;
FILE* e_vapor_2 = NULL;
FILE* dq_eva_2 = NULL;
FILE* dq_rain_2 = NULL;
extern float __mo_state_MOD_cap_surf [XY];
extern float __mo_state_MOD_ts0 [XY];
extern float __mo_state_MOD_ts1 [XY];
extern float __mo_state_MOD_ta0 [XY];
extern float __mo_state_MOD_ta1 [XY];
extern float __mo_state_MOD_to0 [XY];
extern float __mo_state_MOD_to1 [XY];
extern float __mo_state_MOD_q0 [XY];
extern float __mo_state_MOD_q1 [XY];
extern float __mo_state_MOD_a_surf [XY];
extern float __mo_state_MOD_e_vapor [XY];
extern float __mo_state_MOD_dq_eva [XY];
extern float __mo_state_MOD_dq_rain [XY];
extern float __mo_state_MOD_tsmn [XY];
extern float __mo_state_MOD_tamn [XY];
extern float __mo_state_MOD_qmn [XY];
extern float __mo_state_MOD_swmn [XY];
extern float __mo_state_MOD_lwmn [XY];
extern float __mo_state_MOD_qlatmn [XY];
extern float __mo_state_MOD_qsensmn [XY];
extern float __mo_state_MOD_ftmn [XY];
extern float __mo_state_MOD_fqmn [XY];
extern float __mo_state_MOD_icmn [XY];
extern float __mo_state_MOD_tomn [XY];
extern float __mo_state_MOD_tmm [XY];
extern float __mo_state_MOD_tamm [XY];
extern float __mo_state_MOD_tomm [XY];
extern float __mo_state_MOD_qmm [XY];
extern float __mo_state_MOD_icmm [XY];
extern float __mo_state_MOD_tmn_ctrl [XY*12];
extern float __mo_state_MOD_tamn_ctrl [XY*12];
extern float __mo_state_MOD_tomn_ctrl [XY*12];
extern float __mo_state_MOD_qmn_ctrl [XY*12];
extern float __mo_state_MOD_icmn_ctrl [XY*12];
extern float __mo_state_MOD_z_topo [XY];
extern float __mo_state_MOD_glacier [XY];
extern float __mo_state_MOD_z_ocean [XY];
extern float __mo_state_MOD_tclim [XY*730];
extern float __mo_state_MOD_uclim [XY*730];
extern float __mo_state_MOD_vclim [XY*730];
extern float __mo_state_MOD_qclim [XY*730];
extern float __mo_state_MOD_mldclim [XY*730];
extern float __mo_state_MOD_toclim [XY*730];
extern float __mo_state_MOD_cldclim [XY*730];
extern float __mo_state_MOD_tf_correct [XY*730];
extern float __mo_state_MOD_qf_correct [XY*730];
extern float __mo_state_MOD_tof_correct [XY*730];
extern float __mo_state_MOD_swetclim [XY*730];
extern float __mo_state_MOD_dtrad [XY*730];
extern float __mo_state_MOD_sw_solar [YDIM*730];
extern float __mo_state_MOD_sw_solar_ctrl [YDIM*730];
extern float __mo_state_MOD_sw_solar_scnr [YDIM*730];
extern float __mo_state_MOD_co2_part [XY];
extern float __mo_state_MOD_co2_part_scn [XY];
extern float __mo_state_MOD_wz_air [XY];
extern float __mo_state_MOD_wz_vapor [XY];
extern float __mo_state_MOD_uclim_m [XY*730];
extern float __mo_state_MOD_uclim_p [XY*730];
extern float __mo_state_MOD_vclim_m [XY*730];
extern float __mo_state_MOD_vclim_p [XY*730];
extern float __mo_state_MOD_year ;
extern float __mo_state_MOD_co2 ;
extern int __mo_state_MOD_mon ;
extern int __mo_state_MOD_jday ;
extern int __mo_state_MOD_ityr ;
extern bool __mo_state_MOD_inject_q1 ;
extern bool __mo_state_MOD_inject_a_surf ;
extern bool __mo_state_MOD_inject_e_vapor ;
extern bool __mo_state_MOD_inject_dq_eva ;
extern bool __mo_state_MOD_inject_dq_rain ;
typedef struct {
 long a_surf_1_off;
long q1_1_off;
long e_vapor_1_off;
long dq_eva_1_off;
long dq_rain_1_off;
long a_surf_2_off;
long q1_2_off;
long e_vapor_2_off;
long dq_eva_2_off;
long dq_rain_2_off;
float cap_surf [XY];
float ts0 [XY];
float ts1 [XY];
float ta0 [XY];
float ta1 [XY];
float to0 [XY];
float to1 [XY];
float q0 [XY];
float q1 [XY];
float a_surf [XY];
float e_vapor [XY];
float dq_eva [XY];
float dq_rain [XY];
float tsmn [XY];
float tamn [XY];
float qmn [XY];
float swmn [XY];
float lwmn [XY];
float qlatmn [XY];
float qsensmn [XY];
float ftmn [XY];
float fqmn [XY];
float icmn [XY];
float tomn [XY];
float tmm [XY];
float tamm [XY];
float tomm [XY];
float qmm [XY];
float icmm [XY];
float tmn_ctrl [XY*12];
float tamn_ctrl [XY*12];
float tomn_ctrl [XY*12];
float qmn_ctrl [XY*12];
float icmn_ctrl [XY*12];
float z_topo [XY];
float glacier [XY];
float z_ocean [XY];
float tclim [XY*730];
float uclim [XY*730];
float vclim [XY*730];
float qclim [XY*730];
float mldclim [XY*730];
float toclim [XY*730];
float cldclim [XY*730];
float tf_correct [XY*730];
float qf_correct [XY*730];
float tof_correct [XY*730];
float swetclim [XY*730];
float dtrad [XY*730];
float sw_solar [YDIM*730];
float sw_solar_ctrl [YDIM*730];
float sw_solar_scnr [YDIM*730];
float co2_part [XY];
float co2_part_scn [XY];
float wz_air [XY];
float wz_vapor [XY];
float uclim_m [XY*730];
float uclim_p [XY*730];
float vclim_m [XY*730];
float vclim_p [XY*730];
float year ;
float co2 ;
int mon ;
int jday ;
int ityr ;
bool inject_q1 ;
bool inject_a_surf ;
bool inject_e_vapor ;
bool inject_dq_eva ;
bool inject_dq_rain ;
 } State;
static void save(State* state) {
 state->a_surf_1_off = ftell(a_surf_1);
state->q1_1_off = ftell(q1_1);
state->e_vapor_1_off = ftell(e_vapor_1);
state->dq_eva_1_off = ftell(dq_eva_1);
state->dq_rain_1_off = ftell(dq_rain_1);
state->a_surf_2_off = ftell(a_surf_2);
state->q1_2_off = ftell(q1_2);
state->e_vapor_2_off = ftell(e_vapor_2);
state->dq_eva_2_off = ftell(dq_eva_2);
state->dq_rain_2_off = ftell(dq_rain_2);
memcpy( state->cap_surf,  __mo_state_MOD_cap_surf, sizeof(state->cap_surf));
memcpy( state->ts0,  __mo_state_MOD_ts0, sizeof(state->ts0));
memcpy( state->ts1,  __mo_state_MOD_ts1, sizeof(state->ts1));
memcpy( state->ta0,  __mo_state_MOD_ta0, sizeof(state->ta0));
memcpy( state->ta1,  __mo_state_MOD_ta1, sizeof(state->ta1));
memcpy( state->to0,  __mo_state_MOD_to0, sizeof(state->to0));
memcpy( state->to1,  __mo_state_MOD_to1, sizeof(state->to1));
memcpy( state->q0,  __mo_state_MOD_q0, sizeof(state->q0));
memcpy( state->q1,  __mo_state_MOD_q1, sizeof(state->q1));
memcpy( state->a_surf,  __mo_state_MOD_a_surf, sizeof(state->a_surf));
memcpy( state->e_vapor,  __mo_state_MOD_e_vapor, sizeof(state->e_vapor));
memcpy( state->dq_eva,  __mo_state_MOD_dq_eva, sizeof(state->dq_eva));
memcpy( state->dq_rain,  __mo_state_MOD_dq_rain, sizeof(state->dq_rain));
memcpy( state->tsmn,  __mo_state_MOD_tsmn, sizeof(state->tsmn));
memcpy( state->tamn,  __mo_state_MOD_tamn, sizeof(state->tamn));
memcpy( state->qmn,  __mo_state_MOD_qmn, sizeof(state->qmn));
memcpy( state->swmn,  __mo_state_MOD_swmn, sizeof(state->swmn));
memcpy( state->lwmn,  __mo_state_MOD_lwmn, sizeof(state->lwmn));
memcpy( state->qlatmn,  __mo_state_MOD_qlatmn, sizeof(state->qlatmn));
memcpy( state->qsensmn,  __mo_state_MOD_qsensmn, sizeof(state->qsensmn));
memcpy( state->ftmn,  __mo_state_MOD_ftmn, sizeof(state->ftmn));
memcpy( state->fqmn,  __mo_state_MOD_fqmn, sizeof(state->fqmn));
memcpy( state->icmn,  __mo_state_MOD_icmn, sizeof(state->icmn));
memcpy( state->tomn,  __mo_state_MOD_tomn, sizeof(state->tomn));
memcpy( state->tmm,  __mo_state_MOD_tmm, sizeof(state->tmm));
memcpy( state->tamm,  __mo_state_MOD_tamm, sizeof(state->tamm));
memcpy( state->tomm,  __mo_state_MOD_tomm, sizeof(state->tomm));
memcpy( state->qmm,  __mo_state_MOD_qmm, sizeof(state->qmm));
memcpy( state->icmm,  __mo_state_MOD_icmm, sizeof(state->icmm));
memcpy( state->tmn_ctrl,  __mo_state_MOD_tmn_ctrl, sizeof(state->tmn_ctrl));
memcpy( state->tamn_ctrl,  __mo_state_MOD_tamn_ctrl, sizeof(state->tamn_ctrl));
memcpy( state->tomn_ctrl,  __mo_state_MOD_tomn_ctrl, sizeof(state->tomn_ctrl));
memcpy( state->qmn_ctrl,  __mo_state_MOD_qmn_ctrl, sizeof(state->qmn_ctrl));
memcpy( state->icmn_ctrl,  __mo_state_MOD_icmn_ctrl, sizeof(state->icmn_ctrl));
memcpy( state->z_topo,  __mo_state_MOD_z_topo, sizeof(state->z_topo));
memcpy( state->glacier,  __mo_state_MOD_glacier, sizeof(state->glacier));
memcpy( state->z_ocean,  __mo_state_MOD_z_ocean, sizeof(state->z_ocean));
memcpy( state->tclim,  __mo_state_MOD_tclim, sizeof(state->tclim));
memcpy( state->uclim,  __mo_state_MOD_uclim, sizeof(state->uclim));
memcpy( state->vclim,  __mo_state_MOD_vclim, sizeof(state->vclim));
memcpy( state->qclim,  __mo_state_MOD_qclim, sizeof(state->qclim));
memcpy( state->mldclim,  __mo_state_MOD_mldclim, sizeof(state->mldclim));
memcpy( state->toclim,  __mo_state_MOD_toclim, sizeof(state->toclim));
memcpy( state->cldclim,  __mo_state_MOD_cldclim, sizeof(state->cldclim));
memcpy( state->tf_correct,  __mo_state_MOD_tf_correct, sizeof(state->tf_correct));
memcpy( state->qf_correct,  __mo_state_MOD_qf_correct, sizeof(state->qf_correct));
memcpy( state->tof_correct,  __mo_state_MOD_tof_correct, sizeof(state->tof_correct));
memcpy( state->swetclim,  __mo_state_MOD_swetclim, sizeof(state->swetclim));
memcpy( state->dtrad,  __mo_state_MOD_dtrad, sizeof(state->dtrad));
memcpy( state->sw_solar,  __mo_state_MOD_sw_solar, sizeof(state->sw_solar));
memcpy( state->sw_solar_ctrl,  __mo_state_MOD_sw_solar_ctrl, sizeof(state->sw_solar_ctrl));
memcpy( state->sw_solar_scnr,  __mo_state_MOD_sw_solar_scnr, sizeof(state->sw_solar_scnr));
memcpy( state->co2_part,  __mo_state_MOD_co2_part, sizeof(state->co2_part));
memcpy( state->co2_part_scn,  __mo_state_MOD_co2_part_scn, sizeof(state->co2_part_scn));
memcpy( state->wz_air,  __mo_state_MOD_wz_air, sizeof(state->wz_air));
memcpy( state->wz_vapor,  __mo_state_MOD_wz_vapor, sizeof(state->wz_vapor));
memcpy( state->uclim_m,  __mo_state_MOD_uclim_m, sizeof(state->uclim_m));
memcpy( state->uclim_p,  __mo_state_MOD_uclim_p, sizeof(state->uclim_p));
memcpy( state->vclim_m,  __mo_state_MOD_vclim_m, sizeof(state->vclim_m));
memcpy( state->vclim_p,  __mo_state_MOD_vclim_p, sizeof(state->vclim_p));
memcpy(& state->year, & __mo_state_MOD_year, sizeof(state->year));
memcpy(& state->co2, & __mo_state_MOD_co2, sizeof(state->co2));
memcpy(& state->mon, & __mo_state_MOD_mon, sizeof(state->mon));
memcpy(& state->jday, & __mo_state_MOD_jday, sizeof(state->jday));
memcpy(& state->ityr, & __mo_state_MOD_ityr, sizeof(state->ityr));
memcpy(& state->inject_q1, & __mo_state_MOD_inject_q1, sizeof(state->inject_q1));
memcpy(& state->inject_a_surf, & __mo_state_MOD_inject_a_surf, sizeof(state->inject_a_surf));
memcpy(& state->inject_e_vapor, & __mo_state_MOD_inject_e_vapor, sizeof(state->inject_e_vapor));
memcpy(& state->inject_dq_eva, & __mo_state_MOD_inject_dq_eva, sizeof(state->inject_dq_eva));
memcpy(& state->inject_dq_rain, & __mo_state_MOD_inject_dq_rain, sizeof(state->inject_dq_rain));
 }
static void load(State* state) {
 fseek(a_surf_1, state->a_surf_1_off, SEEK_SET);
fseek(q1_1, state->q1_1_off, SEEK_SET);
fseek(e_vapor_1, state->e_vapor_1_off, SEEK_SET);
fseek(dq_eva_1, state->dq_eva_1_off, SEEK_SET);
fseek(dq_rain_1, state->dq_rain_1_off, SEEK_SET);
fseek(a_surf_2, state->a_surf_2_off, SEEK_SET);
fseek(q1_2, state->q1_2_off, SEEK_SET);
fseek(e_vapor_2, state->e_vapor_2_off, SEEK_SET);
fseek(dq_eva_2, state->dq_eva_2_off, SEEK_SET);
fseek(dq_rain_2, state->dq_rain_2_off, SEEK_SET);
memcpy( __mo_state_MOD_cap_surf,  state->cap_surf, sizeof(state->cap_surf));
memcpy( __mo_state_MOD_ts0,  state->ts0, sizeof(state->ts0));
memcpy( __mo_state_MOD_ts1,  state->ts1, sizeof(state->ts1));
memcpy( __mo_state_MOD_ta0,  state->ta0, sizeof(state->ta0));
memcpy( __mo_state_MOD_ta1,  state->ta1, sizeof(state->ta1));
memcpy( __mo_state_MOD_to0,  state->to0, sizeof(state->to0));
memcpy( __mo_state_MOD_to1,  state->to1, sizeof(state->to1));
memcpy( __mo_state_MOD_q0,  state->q0, sizeof(state->q0));
memcpy( __mo_state_MOD_q1,  state->q1, sizeof(state->q1));
memcpy( __mo_state_MOD_a_surf,  state->a_surf, sizeof(state->a_surf));
memcpy( __mo_state_MOD_e_vapor,  state->e_vapor, sizeof(state->e_vapor));
memcpy( __mo_state_MOD_dq_eva,  state->dq_eva, sizeof(state->dq_eva));
memcpy( __mo_state_MOD_dq_rain,  state->dq_rain, sizeof(state->dq_rain));
memcpy( __mo_state_MOD_tsmn,  state->tsmn, sizeof(state->tsmn));
memcpy( __mo_state_MOD_tamn,  state->tamn, sizeof(state->tamn));
memcpy( __mo_state_MOD_qmn,  state->qmn, sizeof(state->qmn));
memcpy( __mo_state_MOD_swmn,  state->swmn, sizeof(state->swmn));
memcpy( __mo_state_MOD_lwmn,  state->lwmn, sizeof(state->lwmn));
memcpy( __mo_state_MOD_qlatmn,  state->qlatmn, sizeof(state->qlatmn));
memcpy( __mo_state_MOD_qsensmn,  state->qsensmn, sizeof(state->qsensmn));
memcpy( __mo_state_MOD_ftmn,  state->ftmn, sizeof(state->ftmn));
memcpy( __mo_state_MOD_fqmn,  state->fqmn, sizeof(state->fqmn));
memcpy( __mo_state_MOD_icmn,  state->icmn, sizeof(state->icmn));
memcpy( __mo_state_MOD_tomn,  state->tomn, sizeof(state->tomn));
memcpy( __mo_state_MOD_tmm,  state->tmm, sizeof(state->tmm));
memcpy( __mo_state_MOD_tamm,  state->tamm, sizeof(state->tamm));
memcpy( __mo_state_MOD_tomm,  state->tomm, sizeof(state->tomm));
memcpy( __mo_state_MOD_qmm,  state->qmm, sizeof(state->qmm));
memcpy( __mo_state_MOD_icmm,  state->icmm, sizeof(state->icmm));
memcpy( __mo_state_MOD_tmn_ctrl,  state->tmn_ctrl, sizeof(state->tmn_ctrl));
memcpy( __mo_state_MOD_tamn_ctrl,  state->tamn_ctrl, sizeof(state->tamn_ctrl));
memcpy( __mo_state_MOD_tomn_ctrl,  state->tomn_ctrl, sizeof(state->tomn_ctrl));
memcpy( __mo_state_MOD_qmn_ctrl,  state->qmn_ctrl, sizeof(state->qmn_ctrl));
memcpy( __mo_state_MOD_icmn_ctrl,  state->icmn_ctrl, sizeof(state->icmn_ctrl));
memcpy( __mo_state_MOD_z_topo,  state->z_topo, sizeof(state->z_topo));
memcpy( __mo_state_MOD_glacier,  state->glacier, sizeof(state->glacier));
memcpy( __mo_state_MOD_z_ocean,  state->z_ocean, sizeof(state->z_ocean));
memcpy( __mo_state_MOD_tclim,  state->tclim, sizeof(state->tclim));
memcpy( __mo_state_MOD_uclim,  state->uclim, sizeof(state->uclim));
memcpy( __mo_state_MOD_vclim,  state->vclim, sizeof(state->vclim));
memcpy( __mo_state_MOD_qclim,  state->qclim, sizeof(state->qclim));
memcpy( __mo_state_MOD_mldclim,  state->mldclim, sizeof(state->mldclim));
memcpy( __mo_state_MOD_toclim,  state->toclim, sizeof(state->toclim));
memcpy( __mo_state_MOD_cldclim,  state->cldclim, sizeof(state->cldclim));
memcpy( __mo_state_MOD_tf_correct,  state->tf_correct, sizeof(state->tf_correct));
memcpy( __mo_state_MOD_qf_correct,  state->qf_correct, sizeof(state->qf_correct));
memcpy( __mo_state_MOD_tof_correct,  state->tof_correct, sizeof(state->tof_correct));
memcpy( __mo_state_MOD_swetclim,  state->swetclim, sizeof(state->swetclim));
memcpy( __mo_state_MOD_dtrad,  state->dtrad, sizeof(state->dtrad));
memcpy( __mo_state_MOD_sw_solar,  state->sw_solar, sizeof(state->sw_solar));
memcpy( __mo_state_MOD_sw_solar_ctrl,  state->sw_solar_ctrl, sizeof(state->sw_solar_ctrl));
memcpy( __mo_state_MOD_sw_solar_scnr,  state->sw_solar_scnr, sizeof(state->sw_solar_scnr));
memcpy( __mo_state_MOD_co2_part,  state->co2_part, sizeof(state->co2_part));
memcpy( __mo_state_MOD_co2_part_scn,  state->co2_part_scn, sizeof(state->co2_part_scn));
memcpy( __mo_state_MOD_wz_air,  state->wz_air, sizeof(state->wz_air));
memcpy( __mo_state_MOD_wz_vapor,  state->wz_vapor, sizeof(state->wz_vapor));
memcpy( __mo_state_MOD_uclim_m,  state->uclim_m, sizeof(state->uclim_m));
memcpy( __mo_state_MOD_uclim_p,  state->uclim_p, sizeof(state->uclim_p));
memcpy( __mo_state_MOD_vclim_m,  state->vclim_m, sizeof(state->vclim_m));
memcpy( __mo_state_MOD_vclim_p,  state->vclim_p, sizeof(state->vclim_p));
memcpy(& __mo_state_MOD_year, & state->year, sizeof(state->year));
memcpy(& __mo_state_MOD_co2, & state->co2, sizeof(state->co2));
memcpy(& __mo_state_MOD_mon, & state->mon, sizeof(state->mon));
memcpy(& __mo_state_MOD_jday, & state->jday, sizeof(state->jday));
memcpy(& __mo_state_MOD_ityr, & state->ityr, sizeof(state->ityr));
memcpy(& __mo_state_MOD_inject_q1, & state->inject_q1, sizeof(state->inject_q1));
memcpy(& __mo_state_MOD_inject_a_surf, & state->inject_a_surf, sizeof(state->inject_a_surf));
memcpy(& __mo_state_MOD_inject_e_vapor, & state->inject_e_vapor, sizeof(state->inject_e_vapor));
memcpy(& __mo_state_MOD_inject_dq_eva, & state->inject_dq_eva, sizeof(state->inject_dq_eva));
memcpy(& __mo_state_MOD_inject_dq_rain, & state->inject_dq_rain, sizeof(state->inject_dq_rain));
 }
static void init_files(const char* mode) {
if((a_surf_1 = fopen("../extractions/1_a_surf.save.bin", mode)) == NULL) die("fopen a_surf_1 as %s", mode);
if((q1_1 = fopen("../extractions/1_q1.save.bin", mode)) == NULL) die("fopen q1_1 as %s", mode);
if((e_vapor_1 = fopen("../extractions/1_e_vapor.save.bin", mode)) == NULL) die("fopen e_vapor_1 as %s", mode);
if((dq_eva_1 = fopen("../extractions/1_dq_eva.save.bin", mode)) == NULL) die("fopen dq_eva_1 as %s", mode);
if((dq_rain_1 = fopen("../extractions/1_dq_rain.save.bin", mode)) == NULL) die("fopen dq_rain_1 as %s", mode);
if((a_surf_2 = fopen("../extractions/2_a_surf.save.bin", mode)) == NULL) die("fopen a_surf_2 as %s", mode);
if((q1_2 = fopen("../extractions/2_q1.save.bin", mode)) == NULL) die("fopen q1_2 as %s", mode);
if((e_vapor_2 = fopen("../extractions/2_e_vapor.save.bin", mode)) == NULL) die("fopen e_vapor_2 as %s", mode);
if((dq_eva_2 = fopen("../extractions/2_dq_eva.save.bin", mode)) == NULL) die("fopen dq_eva_2 as %s", mode);
if((dq_rain_2 = fopen("../extractions/2_dq_rain.save.bin", mode)) == NULL) die("fopen dq_rain_2 as %s", mode);
}
static void inject_all_albedo(int how) {
  inject_albedo = how;
  __mo_state_MOD_inject_a_surf = how;
}
static void inject_all_vapor(int how) {
  inject_vapor = how;
  __mo_state_MOD_inject_q1 = how;
  __mo_state_MOD_inject_e_vapor = how;
  __mo_state_MOD_inject_dq_eva = how;
  __mo_state_MOD_inject_dq_rain = how;
}
static void inject_all(int how) {
  inject_all_albedo(how);
  inject_all_vapor(how);
}
static void extract_all_albedo(int how) {
  extract_albedo = how;
}
static void extract_all_vapor(int how) {
  extract_vapor = how;
}
static void extract_all(int how) {
  extract_all_albedo(how);
  extract_all_vapor(how);
}
void hook_(void) {
  if(inject_albedo == 1) {
    if(fread(__mo_state_MOD_a_surf, ITM(__mo_state_MOD_a_surf), LEN(__mo_state_MOD_a_surf), a_surf_1) != LEN(__mo_state_MOD_a_surf)) die("fread a_surf_1");
  }
  if(inject_vapor == 1) {
    if(fread(__mo_state_MOD_q1, ITM(__mo_state_MOD_q1), LEN(__mo_state_MOD_q1), q1_1) != LEN(__mo_state_MOD_q1)) die("fread q1_1");
    if(fread(__mo_state_MOD_e_vapor, ITM(__mo_state_MOD_e_vapor), LEN(__mo_state_MOD_e_vapor), e_vapor_1) != LEN(__mo_state_MOD_e_vapor)) die("fread e_vapor_1");
    if(fread(__mo_state_MOD_dq_eva, ITM(__mo_state_MOD_dq_eva), LEN(__mo_state_MOD_dq_eva), dq_eva_1) != LEN(__mo_state_MOD_dq_eva)) die("fread dq_eva_1");
    if(fread(__mo_state_MOD_dq_rain, ITM(__mo_state_MOD_dq_rain), LEN(__mo_state_MOD_dq_rain), dq_rain_1) != LEN(__mo_state_MOD_dq_rain)) die("fread dq_rain_1");
  }
  if(extract_albedo == 1) {
    if(fwrite(__mo_state_MOD_a_surf, ITM(__mo_state_MOD_a_surf), LEN(__mo_state_MOD_a_surf), a_surf_1) != LEN(__mo_state_MOD_a_surf)) die("fwrite a_surf_1");
  }
  if(extract_vapor == 1) {
    if(fwrite(__mo_state_MOD_q1, ITM(__mo_state_MOD_q1), LEN(__mo_state_MOD_q1), q1_1) != LEN(__mo_state_MOD_q1)) die("fwrite q1_1");
    if(fwrite(__mo_state_MOD_e_vapor, ITM(__mo_state_MOD_e_vapor), LEN(__mo_state_MOD_e_vapor), e_vapor_1) != LEN(__mo_state_MOD_e_vapor)) die("fwrite e_vapor_1");
    if(fwrite(__mo_state_MOD_dq_eva, ITM(__mo_state_MOD_dq_eva), LEN(__mo_state_MOD_dq_eva), dq_eva_1) != LEN(__mo_state_MOD_dq_eva)) die("fwrite dq_eva_1");
    if(fwrite(__mo_state_MOD_dq_rain, ITM(__mo_state_MOD_dq_rain), LEN(__mo_state_MOD_dq_rain), dq_rain_1) != LEN(__mo_state_MOD_dq_rain)) die("fwrite dq_rain_1");
  }
  if(inject_albedo == 2) {
    if(fread(__mo_state_MOD_a_surf, ITM(__mo_state_MOD_a_surf), LEN(__mo_state_MOD_a_surf), a_surf_2) != LEN(__mo_state_MOD_a_surf)) die("fread a_surf_2");
  }
  if(inject_vapor == 2) {
    if(fread(__mo_state_MOD_q1, ITM(__mo_state_MOD_q1), LEN(__mo_state_MOD_q1), q1_2) != LEN(__mo_state_MOD_q1)) die("fread q1_2");
    if(fread(__mo_state_MOD_e_vapor, ITM(__mo_state_MOD_e_vapor), LEN(__mo_state_MOD_e_vapor), e_vapor_2) != LEN(__mo_state_MOD_e_vapor)) die("fread e_vapor_2");
    if(fread(__mo_state_MOD_dq_eva, ITM(__mo_state_MOD_dq_eva), LEN(__mo_state_MOD_dq_eva), dq_eva_2) != LEN(__mo_state_MOD_dq_eva)) die("fread dq_eva_2");
    if(fread(__mo_state_MOD_dq_rain, ITM(__mo_state_MOD_dq_rain), LEN(__mo_state_MOD_dq_rain), dq_rain_2) != LEN(__mo_state_MOD_dq_rain)) die("fread dq_rain_2");
  }
  if(extract_albedo == 2) {
    if(fwrite(__mo_state_MOD_a_surf, ITM(__mo_state_MOD_a_surf), LEN(__mo_state_MOD_a_surf), a_surf_2) != LEN(__mo_state_MOD_a_surf)) die("fwrite a_surf_2");
  }
  if(extract_vapor == 2) {
    if(fwrite(__mo_state_MOD_q1, ITM(__mo_state_MOD_q1), LEN(__mo_state_MOD_q1), q1_2) != LEN(__mo_state_MOD_q1)) die("fwrite q1_2");
    if(fwrite(__mo_state_MOD_e_vapor, ITM(__mo_state_MOD_e_vapor), LEN(__mo_state_MOD_e_vapor), e_vapor_2) != LEN(__mo_state_MOD_e_vapor)) die("fwrite e_vapor_2");
    if(fwrite(__mo_state_MOD_dq_eva, ITM(__mo_state_MOD_dq_eva), LEN(__mo_state_MOD_dq_eva), dq_eva_2) != LEN(__mo_state_MOD_dq_eva)) die("fwrite dq_eva_2");
    if(fwrite(__mo_state_MOD_dq_rain, ITM(__mo_state_MOD_dq_rain), LEN(__mo_state_MOD_dq_rain), dq_rain_2) != LEN(__mo_state_MOD_dq_rain)) die("fwrite dq_rain_2");
  }
}

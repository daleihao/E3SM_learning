 export code_root_dir=e3sm_top_AMIP_true
 mkdir -p $code_root_dir
  git clone git@github.com:e3sm-project/e3sm  $code_root_dir    # This will put repository, with all code, in directory $tag_name
  ## Setup git hooks
  rm -rf $code_root_dir/.git/hooks
  git clone git@github.com:e3sm-project/e3sm-Hooks.git $code_root_dir/.git/hooks         # checkout with write permission.
#  git clone git://github.com/ACME-Climate/ACME-Hooks.git .git/hooks      # checkout read-only.
  cd $code_root_dir
  git config commit.template $code_root_dir/.git/hooks/commit.template
  ## Bring in MPAS ocean/ice repo
  git submodule update --init
git checkout --detach


export RES=ne30pg2_r05_oECv3
export COMPSET=F20TRC5-CMIP6
export COMPILER=intel
export MACH=compy
export CASE_NAME=test3_AMIP.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts
./create_newcase -compset  ${COMPSET} -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=5,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="4:00:00",RUN_STARTDATE="1985-01-01",REST_N=5,REST_OPTION=ndays
./xmlchange CAM_TARGET=theta-l
./xmlchange --id CAM_CONFIG_OPTS --append --val='-cosp'



cat >> user_nl_cam << EOF
 nhtfrq =   0
 mfilt  = 1
 avgflag_pertape = 'A'
 fexcl1 = 'CFAD_SR532_CAL'
 fincl1 = 'extinct_sw_inp','extinct_lw_bnd7','extinct_lw_inp','CLD_CAL', 'TREFMNAV', 'TREFMXAV'
 ncdata = '/compyfs/gola749/E3SM_simulations/20180316.DECKv1b_A1.ne30_oEC.edison/archive/rest/1980-01-01-00000/20180316.DECKv1b_A1.ne30_oEC.edison.cam.i.1980-01-01-00000.nc'
 ieflx_opt = 0 ! =0 AMIP simulations, = 2 for coupled
 clubb_c_K10h = 0.30
 clubb_c14 = 1.06D0
 dust_emis_fact	=  1.50D0
 linoz_psc_T = 197.5
EOF

cat >> user_nl_clm << EOF
 check_finidat_year_consistency = .false.
 fsurdat = "/compyfs/inputdata/lnd/clm2/surfdata_map/surfdata_0.5x0.5_simyr1850_c190418.nc"
 flanduse_timeseries = "/compyfs/inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.5x0.5_hist_simyr1850-2015_c191004.nc"
 finidat = '/compyfs/gola749/E3SM_simulations/20200620.v1like.amip.ne30pg2_r05_oECv3.compy/init/finidat_interp_20180316.DECKv1b_A1.ne30_oEC.edison.clm2.r.1980-01-01-00000_DECKv1.nc'
 rad_3d_topo = .false.
 f3dtopo = ''
 hist_empty_htapes = .true.
 hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
 hist_nhtfrq = 0
 hist_mfilt  = 1
EOF

./case.setup
./case.build
./case.submit

##
#!/bin/bash
module unload python
module load python/2.7.9
./create_newcase -case FC5AV1C-L_ne4pg2_ne4pg2_20yrs -compset FC5AV1C-L -res ne4pg2_ne4pg2 --handle-preexisting-dirs r
cd FC5AV1C-L_ne4pg2_ne4pg2_20yrs

./xmlchange JOB_WALLCLOCK_TIME='08:00:00'

./xmlchange CAM_TARGET=theta-l
./xmlchange --id CAM_CONFIG_OPTS --append --val='-cosp'

./xmlchange --id STOP_OPTION --val 'nyears'
./xmlchange --id STOP_N      --val 20

./xmlchange --id REST_OPTION --val 'nyears'
./xmlchange --id REST_N      --val 5

./xmlchange --id BUDGETS     --val 'true'

./xmlchange --id HIST_OPTION --val 'nyears'
./xmlchange --id HIST_N      --val 5

# FIXME : Add the variable below back to user_nl_cam
#ncdata = '../init/20171228.beta3rc13_1850.ne30_oECv3_ICG.edison.cam.i.0331-01-01-00000.nc'

cat <<EOF >> user_nl_cam
nhtfrq =   0,-24,-6,-6,-3,-24
mfilt  = 1,30,120,120,240,30
avgflag_pertape = 'A','A','I','A','A','A'
fexcl1 = 'CFAD_SR532_CAL'
fincl1 = 'extinct_sw_inp','extinct_lw_bnd7','extinct_lw_inp','CLD_CAL', 'TREFMNAV', 'TREFMXAV'
fincl2 = 'FLUT','PRECT','U200','V200','U850','V850','Z500','OMEGA500','UBOT','VBOT','TREFHT','TREFHTMN','TREFHTMX','QREFHT','TS','PS','TMQ','TUQ','TVQ','TOZ'
fincl3 = 'PSL','T200','T500','U850','V850','UBOT','VBOT','TREFHT'
fincl4 = 'FLUT','U200','U850','PRECT','OMEGA500'
fincl5 = 'PRECT','PRECC'
fincl6 = 'CLDTOT_ISCCP','MEANCLDALB_ISCCP','MEANTAU_ISCCP','MEANPTOP_ISCCP','MEANTB_ISCCP','CLDTOT_CAL','CLDTOT_CAL_LIQ','CLDTOT_CAL_ICE','CLDTOT_CAL_UN','CLDHGH_CAL','CLDHGH_CAL_LIQ','CLDHGH_CAL_ICE','CLDHGH_CAL_UN','CLDMED_CAL','CLDMED_CAL_LIQ','CLDMED_CAL_ICE','CLDMED_CAL_UN','CLDLOW_CAL','CLDLOW_CAL_LIQ','CLDLOW_CAL_ICE','CLDLOW_CAL_UN'

ieflx_opt = 2 ! =0 AMIP simulations, = 2 for coupled

clubb_c_K10h = 0.30
clubb_c14 = 1.06D0
dust_emis_fact =  1.50D0
linoz_psc_T = 197.5
EOF

./case.setup
./case.build
./case.submit




## AMIP

export RES=ne30pg2_r05_oECv3
export COMPSET=F20TRC5-CMIP6
export COMPILER=intel
export MACH=compy
export CASE_NAME=test4_AMIP.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_AMIP/cime/scripts
./create_newcase -compset  ${COMPSET} -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=5,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="4:00:00",RUN_STARTDATE="1985-01-01",REST_N=5,REST_OPTION=ndays
./xmlchange CAM_TARGET=theta-l
./xmlchange --id CAM_CONFIG_OPTS --append --val='-cosp'



cat >> user_nl_cam << EOF
 nhtfrq =   0
 mfilt  = 1
 avgflag_pertape = 'A'
 fexcl1 = 'CFAD_SR532_CAL'
 fincl1 = 'extinct_sw_inp','extinct_lw_bnd7','extinct_lw_inp','CLD_CAL', 'TREFMNAV', 'TREFMXAV'
 ncdata = '/compyfs/gola749/E3SM_simulations/20180316.DECKv1b_A1.ne30_oEC.edison/archive/rest/1980-01-01-00000/20180316.DECKv1b_A1.ne30_oEC.edison.cam.i.1980-01-01-00000.nc'
 ieflx_opt = 0 ! =0 AMIP simulations, = 2 for coupled
 clubb_c_K10h = 0.30
 clubb_c14 = 1.06D0
 dust_emis_fact	=  1.50D0
 linoz_psc_T = 197.5
EOF

cat >> user_nl_clm << EOF
 check_finidat_year_consistency = .false.
 fsurdat = "/compyfs/inputdata/lnd/clm2/surfdata_map/surfdata_0.5x0.5_simyr1850_c190418.nc"
 flanduse_timeseries = "/compyfs/inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.5x0.5_hist_simyr1850-2015_c191004.nc"
 finidat = '/compyfs/gola749/E3SM_simulations/20200620.v1like.amip.ne30pg2_r05_oECv3.compy/init/finidat_interp_20180316.DECKv1b_A1.ne30_oEC.edison.clm2.r.1980-01-01-00000_DECKv1.nc'
 hist_empty_htapes = .true.
 hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
 hist_nhtfrq = 0
 hist_mfilt  = 1
EOF

./case.setup
./case.build
./case.submit

# Compy
# half Hourly 1 degree
## notpo
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour_daily_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'
./xmlchange DATM_MODE="CLMCRUNCEPv7",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TG','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 48, 1
EOF

./case.setup

./case.build

./case.submit

## top
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour_daily_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 48, 1
EOF


./case.setup

./case.build

./case.submit

echo success


# Compy
# half Hourly 0.5 degree
## notpo
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour_daily_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 48, 1
EOF

./case.setup

./case.build

./case.submit

## top
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour_daily_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.5x0.5.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 48, 1
EOF


./case.setup

./case.build

./case.submit

echo success

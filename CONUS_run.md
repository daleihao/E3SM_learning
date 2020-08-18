# GRID Resolution
conusx4v1

## top
export RES=conusx4v1_conusx4v1
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour4_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=3,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="0:30:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success
  
  
  
  # r0125_r0125
  export RES=r0125_r0125
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour5_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=1024,STOP_N=3,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="0:30:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
fsurdat = '/compyfs/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2010_c191025.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success



  # r0125_r0125
  export RES=r0125_r0125
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour6_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=1024,STOP_N=1,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
fsurdat = '/compyfs/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2010_c191025.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success

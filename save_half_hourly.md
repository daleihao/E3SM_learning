# half Hourly 1 degree
## notpo
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhourly_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = 1
hist_mfilt  = 48
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
EOF

./case.setup

./case.build

./case.submit

## top
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhourly_top.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success



# half Hourly 0.5 degree
## notpo
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhourly6_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange  NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="6:00:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = 1
hist_mfilt  = 48
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
EOF


./case.setup

./case.build

./case.submit

## top
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhourly6_top.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="6:00:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.5x0.5.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success



# different resolutions 0.125
export RES=r0125_r0125
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl    #cori-knl
export CASE_NAME=Halfhourly6_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=1024
./xmlchange STOP_N=3,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="12:00:00",REST_N=1,REST_OPTION=nmonths,RESUBMIT=3,RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
fsurdat = '/global/cfs/cdirs/e3sm/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2000_c190730.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF
# fsurdat = '/compyfs/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr1850_c190730.nc'
#f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.23x0.31_c150322.nc'

./case.setup

./case.build

./case.submit







export RES=r0125_r0125
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhourly6_top.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=1024
./xmlchange STOP_N=3,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="12:00:00",REST_N=1,REST_OPTION=nmonths,RESUBMIT=3,RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
fsurdat = '/global/cfs/cdirs/e3sm/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2000_c190730.nc'
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.125x0.125.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD',
'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success




# Compy
# half Hourly 1 degree
## notpo
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour4_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="3:00:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = 1
hist_mfilt  = 48
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOMELT','QRUNOFF','QOVER','FSDSVD','FSDSVI','FSRVD','FSRVI','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
EOF

./case.setup

./case.build

./case.submit

## top
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour4_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="3:00:00",RUN_STARTDATE="2000-01-01"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
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

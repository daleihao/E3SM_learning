# half Hourly 1 degree
## notpo
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhour_notop.${RES}.${COMPSET}.${COMPILER}

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
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
EOF

./case.setup

./case.build

./case.submit

## top
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhour_top.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
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
export CASE_NAME=Halfhour_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange  NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = 1
hist_mfilt  = 48
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
EOF


./case.setup

./case.build

./case.submit

## top
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=Halfhour_top.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.5x0.5.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
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
export CASE_NAME=Halfhour_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = 1
hist_mfilt  = 48
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
EOF

./case.setup

./case.build

./case.submit

## top
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=Halfhour_top.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','fd_3d_adjust','fi_3d_adjust','FSA','FSR','FSDSND','FSDSNI','SWup','FSRND','FSRNI','FSH','EFLX_LH_TOT','TSOI_10CM','TV','TSA','QSNOWMELT','QRUNOFF','QOVER','SNOWLIQ'
hist_nhtfrq = 1
hist_mfilt  = 48
EOF


./case.setup

./case.build

./case.submit

echo success

# Daily

export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_notop_diurnal.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=3,STOP_OPTION=ndays

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_nhtfrq = -24
hist_mfilt  = 3
EOF

#f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_top_daily.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=3,STOP_OPTION=ndays

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
hist_nhtfrq = -24
hist_mfilt  = 3
EOF


./case.setup

./case.build

./case.submit

echo success


# Monthly
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_notop_monthly.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
EOF

#f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_top_monthly.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
EOF


./case.setup

./case.build

./case.submit

echo success


# 10 year


export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_notop_10years.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
EOF

#f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_top_10years.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.9x1.25_c150322.nc'
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
export CASE_NAME=new2_notop_monthly_0.125.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange NTASKS=512
./xmlchange STOP_N=1,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="1:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
fsurdat = '/global/cfs/cdirs/e3sm/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2000_c190730.nc'
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
export CASE_NAME=new_top_monthly_0.125.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
fsurdat = '/global/cfs/cdirs/e3sm/inputdata/lnd/clm2/surfdata_map/surfdata_0.125x0.125_simyr2000_c190730.nc'
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.125x0.125.nc'
EOF


./case.setup

./case.build

./case.submit

echo success


# 0.5
export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=new_notop_monthly_0.5.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="3:00:00"


cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
EOF

#f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.47x0.63_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=r05_r05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=new_top_monthly_0.5.${RES}.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00"

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/topo_3d_0.5x0.5.nc'
EOF


./case.setup

./case.build

./case.submit

echo success

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


# different resolutions 0.25
export RES=f02_f02
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_notop_monthly_0.25.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
EOF

#f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.23x0.31_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=f02_f02
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_top_monthly_0.25.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.23x0.31_c150322.nc'
EOF


./case.setup

./case.build

./case.submit

echo success


# 0.5
export RES=f05_f05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_notop_monthly_0.5.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
EOF

#f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.23x0.31_c150322.nc'

./case.setup

./case.build

./case.submit








export RES=f05_f05
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=new_top_monthly_0.5.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts

./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD

cd ${CASE_NAME}

./xmlchange STOP_N=1,STOP_OPTION=nyears

cat >> user_nl_clm << EOF
rad_3d_topo = .true.
f3dtopo = '/qfs/people/haod776/UCLA_3D_Topo_Data/topo_3d_0.23x0.31_c150322.nc'
EOF


./case.setup

./case.build

./case.submit

echo success

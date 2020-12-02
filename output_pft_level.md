# 10 year

# Compy  f09_f09
# half Hourly 1 degree
## notpo
export RES=f09_f09
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=test5_output_CLMGSWP3v1_notop.${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm_top/cime/scripts
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${CASE_NAME}

./xmlchange NTASKS=128,STOP_N=3,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="00:30:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=ndays
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'TG', 'FSH', 'Qh'
hist_fincl2 = 'TG', 'FSH', 'Qh'
hist_fincl3 = 'TG', 'FSH', 'Qh'
hist_fincl4 = 'TG', 'FSH', 'Qh'
hist_dov2xy = .true., .false., .false., .false.
hist_type1d_pertape = ' ', '', '', ''
hist_nhtfrq = 1, 1, 1, 1
hist_mfilt  = 48, 48, 48, 48
EOF

./case.setup
./case.build
./case.submit

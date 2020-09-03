# Create domain and surface data file for a point of a regions

use user-defined grid
Create surface and domain files see https://github.com/bishtgautam/matlab-script-for-clm-sparse-grid
run a case using new grid data 

# Script
export RES=CLM_USRDAT
export COMPSET=ICLM45 
export COMPILER=intel 
export MACH=compy 
export CASE_NAME=TEST5_${RES}.${COMPSET}.${COMPILER}
cd ~/e3sm_AMIP/cime/scripts 
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD 
cd ${CASE_NAME}
./xmlchange LND_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange ATM_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange LND_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid 
./xmlchange ATM_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="1:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TG','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 17520, 365
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid/surfdata_82x1_sparse_grid_c200711.nc'
EOF

./case.setup 
./case.build 
./case.submit



# Script
export RES=CLM_USRDAT
export COMPSET=ICLM45 
export COMPILER=intel 
export MACH=compy 
export CASE_NAME=TEST3_${RES}.${COMPSET}.${COMPILER}
cd ~/e3sm/cime/scripts 
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD 

cd ${CASE_NAME}

./xmlchange LND_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange ATM_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange LND_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid 
./xmlchange ATM_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid

./xmlchange NTASKS=128,STOP_N=10,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="1:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TG','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 17520, 365
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid/surfdata_82x1_sparse_grid_c200711.nc'
EOF

./case.setup 
./case.build 
./case.submit



## test
export RES=CLM_USRDAT
export COMPSET=ICLM45 
export COMPILER=intel 
export MACH=compy 
export CASE_NAME=TEST6_${RES}.${COMPSET}.${COMPILER}
cd ~/e3sm_AMIP/cime/scripts 
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD 
cd ${CASE_NAME}
./xmlchange LND_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange ATM_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange LND_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid 
./xmlchange ATM_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid

./xmlchange NTASKS=128,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="1:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI'
hist_fincl2 = 'FSH','EFLX_LH_TOT','TSOI_10CM','TV','TG','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 17520, 365
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid/surfdata_82x1_sparse_grid_c200711.nc'
EOF

./case.setup 
./case.build 
./case.submit



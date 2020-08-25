# Create domain and surface data file for a point of a regions

use user-defined grid
Create surface and domain files see https://github.com/bishtgautam/matlab-script-for-clm-sparse-grid
run a case using new grid data 
export RES=CLM_USRDAT
export COMPSET=ICLM45 
export COMPILER=intel 
export MACH=compy 
export CASE_NAME=${RES}.${COMPSET}.${COMPILER}
cd ~/e3sm/cime/scripts 
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD 
./xmlchange STOP_N=1,STOP_OPTION=nyears 
./xmlchange LND_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange ATM_DOMAIN_FILE=domain_82x1_sparse_grid_c200711.nc 
./xmlchange LND_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid 
./xmlchange ATM_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid

cat >> user_nl_clm << EOF
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/82x1_sparse_grid/surfdata_82x1_sparse_grid_c200711.nc'
EOF

./case.setup 
./case.build 
./case.submit

# Get the E3SM code
git clone https://github.com/daleihao/E3SM.git e3sm
 
cd e3sm

git fetch origin

git checkout origin/master

git submodule update --init --recursive

# Run an E3SM simulation

#export RES=1x1_brazil # This is a single grid cell
export RES=f09_f09 # This is a 1-deg resolution
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=${RES}.${COMPSET}.${COMPILER}
 
#1. Create a case
cd ~/e3sm/cime/scripts
./create_newcase -case ${CASE_NAME} -compset ${COMPSET} -res ${RES} -compiler ${COMPILER} -mach ${MACH} -project ESMD
 
#2. Setup the case.
#    Make any changes to the case before building the case
cd $CASE_NAME
 
#By default, the model runs only for 1-year. Make the following change to run the model
#for 1-year.
./xmlchange STOP_N=1,STOP_OPTION=nyears
 
#Set up the case
./case.setup
 
#3. Build the case
./case.build
 
 
 #if failed, change PIO_version
 ./xmlchange PIO_VERSION=1
./case.build --clean-all
./case.build

#4. Submit the case
./case.submit

# use user-defined grid
1. Create surface and domain files
see https://github.com/bishtgautam/matlab-script-for-clm-sparse-grid
2. run a case using new grid data
export RES=CLM_USRDAT
export COMPSET=ICLM45
export COMPILER=intel
export MACH=compy
export CASE_NAME=${RES}.${COMPSET}.${COMPILER}

cd ~/e3sm/cime/scripts
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH}  -project ESMD
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


# open/close the mosart
If .true., turn on rtm river routing

Default: .true.

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


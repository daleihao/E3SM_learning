http://www.cesm.ucar.edu/models/cesm1.2/clm/models/lnd/clm/doc/UsersGuide/x12544.html


#!/bin/sh
# Lingcheng Li, 2022-03

##############################
####     Start Control    ####
##############################
export case_base=bgc_03-01

#exit change the flag_ !!!!!!!

#!!!!!!!!!!!! Important !!!!!!!!!
export flag_sp1=0
export flag_sp2=1
export flag_sp3=0
export RESOLUT=ELMMOS_USRDAT #ELM_USRDAT #ELMMOS_USRDAT #NLDAS_NLDAS

# 1
export compset1=ICNRDCTCBC #I1850CNRDCTCBC, ICNRDCTCBC  # OLD pypass: ICB1850CNRDCTCBC
export CASE_NAM1=${case_base}.spin1.${compset1}.${RESOLUT}
export iSTPn1=1000
export iRSBn1=0
export iPRSn1=1000

# 2
export compset2=ICNPRDCTCBC #I1850CNPRDCTCBC, ICNPRDCTCBC # OLD pypass: ICB1850CNPRDCTCBC
export CASE_NAM2=${case_base}.spin2.${compset2}.${RESOLUT}
export iSTPn2=3000
export iRSBn2=0
export iPRSn2=1000

#GIT_HASH=`git log -n 1 --format=%h`

export SRC_DIR=/qfs/people/lili400/compy/project/ICoM/e3sm_trial #~/compy/E3SM_code/E3SM
export PROJECT=e3sm
export CASE_ROT=/compyfs/lili400/e3sm_scratch/elm_bgc
export CASE_OUT=/compyfs/lili400/e3sm_scratch
#export SCTH_DIR=/compyfs/lili400/e3sm_scratch/elm_bgc/spinup
export MACHINE=compy
export COMPILER=intel

##########################################################################################
#################################### ELM-BGC Spin 1  #####################################
##########################################################################################

if [[ $flag_sp1 -eq 1 ]]
then

    export iNPRS=$iPRSn1
    export iSTOP=$iSTPn1
    export iRESUB=$iRSBn1
    export iCMPST=$compset1

    CASE_dir=${CASE_ROT}/${CASE_NAM1}
    CASE_bld=${CASE_OUT}/${CASE_NAM1}

    echo -e "\n---------------- 1. E3SM-bgc spin1: " ${CASE_dir}  $iCMPST "----------------"

    ########################################################
    echo -e "\n---------- 1.1 Create Case ---------\n"

    cd ${SRC_DIR}/cime/scripts

    rm -r ${CASE_dir}
    rm -r ${CASE_bld}
    ./create_newcase -case ${CASE_dir} \
    -compset ${iCMPST} -res ${RESOLUT}  -mach ${MACHINE} -project ${PROJECT} -compiler ${COMPILER}
    echo -e "\n-- RES " ${RESOLUT} " -- COMPSET " ${iCMPST} "\n"

    ########################################################
    echo -e "\n---------- 1.2 setup Case ---------\n"

    cd ${CASE_dir}

    ./xmlchange -file env_workflow.xml JOB_WALLCLOCK_TIME="96:00:00"
    ./xmlchange --force -file env_workflow.xml JOB_QUEUE=slurm
    #./xmlchange -file env_workflow.xml JOB_WALLCLOCK_TIME="2:00:00"
    #./xmlchange --force -file env_workflow.xml JOB_QUEUE=short

    ./xmlchange -file env_mach_pes.xml -id NTASKS_LND -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ATM -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_CPL -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ROF -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ICE -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_OCN -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_GLC -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_WAV -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ESP -val ${iNPRS}

    ./xmlchange MAX_TASKS_PER_NODE=40
    ./xmlchange MAX_MPITASKS_PER_NODE=40
    ./xmlchange -file env_mach_pes.xml -id NTHRDS -val 4
    ./xmlquery MAX_TASKS_PER_NODE,NTASKS_LND,NTASKS_ATM,NTASKS_CPL,NTHRDS,MAX_MPITASKS_PER_NODE

    ./xmlchange DATM_CLMNCEP_YR_START=1960
    ./xmlchange DATM_CLMNCEP_YR_END=1962
    ./xmlchange DATM_CLMNCEP_YR_ALIGN=1960

    ./xmlchange -file env_run.xml -id STOP_N -val $iSTOP
    ./xmlchange -file env_run.xml -id REST_N -val 50
    ./xmlchange -file env_run.xml -id STOP_OPTION -val nyears
    ./xmlchange -file env_run.xml -id RESUBMIT -val $iRESUB
    ./xmlchange -file env_run.xml -id CONTINUE_RUN -val FALSE
    ./xmlchange -file env_run.xml -id RUN_STARTDATE -val 0001-01-01
    ./xmlchange -file env_run.xml -id SAVE_TIMING_DIR -val ${CASE_dir}
    #./xmlchange -file env_run.xml -id ELM_BLDNML_OPTS -val "-bgc bgc -nutrient cnp -nutrient_comp_pathway rd  -soil_decomp ctc -methane -bgc_spinup on"
    ./xmlchange -file env_run.xml -id ELM_BLDNML_OPTS -val "-bgc bgc -nutrient cnp -nutrient_comp_pathway rd  -soil_decomp ctc -methane -bgc_spinup on"

    # add by LLC
    ./xmlchange DATM_MODE=CLM_QIAN
    ./xmlchange -file env_run.xml -id DOUT_S_SAVE_INTERIM_RESTART_FILES -val TRUE
    ./xmlchange -file env_run.xml -id DOUT_S -val FALSE
    ./xmlchange -file env_run.xml -id BARRIER_OPTION -val never
    #./xmlchange -file env_run.xml -id DOUT_S_ROOT -val '$CASE_ROT/run'
    ./xmlchange -file env_run.xml -id RUNDIR -val ${CASE_dir}/run

    ./xmlchange LND_DOMAIN_PATH=/qfs/people/lili400/compy/project/ICoM/ELM-BGC/data/surface_data/elm_6km,LND_DOMAIN_FILE=domain_ICoM_6km_1D.nc
    ./xmlchange ATM_DOMAIN_PATH='$LND_DOMAIN_PATH',ATM_DOMAIN_FILE='$LND_DOMAIN_FILE'
    ./xmlquery LND_DOMAIN_PATH,LND_DOMAIN_FILE,ATM_DOMAIN_PATH,ATM_DOMAIN_FILE

    ./xmlchange ELM_CO2_TYPE=constant
    ./xmlchange CCSM_CO2_PPMV=317.04
    ./xmlquery ELM_CO2_TYPE,CCSM_CO2_PPMV

    # ./xmlchange LND_DOMAIN_PATH=/qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/0.0_data_pros/1.a_test_data,LND_DOMAIN_FILE=domain_test_8th.nc

    echo -e "\n---------- 1.3 setup user_nl ---------\n"
cat >> user_nl_elm <<EOF
hist_mfilt = 1
hist_nhtfrq = -175200
hist_fincl1 = 'PFT_CTRUNC'

finidat = ''
fsurdat = '/qfs/people/lili400/compy/project/ICoM/ELM-BGC/data/surface_data/elm_6km/surfdata_ICoM_6km_1D.nc'
flanduse_timeseries = ''

fsoilordercon = '/compyfs/tanz151/user_inputdata/lnd/clm2/paramdata/CNP_ctc_parameters.nc'
stream_fldfilename_ndep = '/compyfs/inputdata/lnd/clm2/ndepdata/fndep_clm_rcp4.5_simyr1849-2106_1.9x2.5_c100428.nc'
co2_file  = '/compyfs/inputdata/atm/datm7/CO2/fco2_datm_rcp4.5_1765-2500_c130312.nc'
aero_file = '/compyfs/inputdata/atm/cam/chem/trop_mozart_aero/aero/aerosoldep_rcp4.5_monthly_1849-2104_1.9x2.5_c100402.nc'
paramfile = '/compyfs/tanz151/user_inputdata/lnd/clm2/paramdata/clm_params.ctc.erosion.nc'

!co2_type = 'constant'
!CO2 average of 1960-1962
co2_ppmv = 317.04

use_dynroot = .false.
use_lch4    = .true.
use_nofire  = .true.

suplphos = 'ALL'             ! P
nyears_ad_carbon_only   = 25 !
spinup_mortality_factor = 10 ! vege dead faster
spinup_state = 1             ! 0 normal spinup

EOF

cat  >> user_nl_mosart <<EOF
do_rtm = .false.
inundflag = .false.
opt_elevprof = 1

frivinp_rtm = '/compyfs/xudo627/new_mesh/inputdata/MOSART_Mid-Atlantic_MPAS_c220107.nc'
!frivinp_rtm = '/compyfs/lili400/project/HighR/data/mosart/NLDAS_mosart_8th_202102.nc'

!rtmhist_nhtfrq= 0,-3
!rtmhist_mfilt = 1, 8
!rtmhist_fincl1='OUTLETG','FLOODED_FRACTION','FLOODPLAIN_FRACTION','FLOODPLAIN_VOLUME','QSUR_LIQ','QSUB_LIQ','QGWL_LIQ','STORAGE_LIQ','Main_Channel_STORAGE_LIQ','RIVER_DISCHARGE_OVER_LAND_LIQ','RIVER_DISCHARGE_TO_OCEAN_LIQ'
!rtmhist_fincl2='OUTLETG','FLOODED_FRACTION','FLOODPLAIN_FRACTION','FLOODPLAIN_VOLUME','QSUR_LIQ','QSUB_LIQ','QGWL_LIQ','STORAGE_LIQ','Main_Channel_STORAGE_LIQ','RIVER_DISCHARGE_OVER_LAND_LIQ','RIVER_DISCHARGE_TO_OCEAN_LIQ'

EOF

cat >> user_nl_datm << EOF
mapalgo = "nn", "nn", "nn"
EOF

    echo -e "-- 1.4 update: datm.streams --"
    ./case.setup
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.Precip_1960-1962 ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.Precip
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.Solar_1960-1962  ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.Solar
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.TPQW_1960-1962   ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.TPQW

    echo -e "\n---------- 5. build Case ---------\n"
    ./case.setup
    ./case.build
    exit
    ./case.submit

    exit
fi



##########################################################################################
#################################### ELM-BGC Spin 2  #####################################
##########################################################################################

if [[ $flag_sp2 -eq 1 ]]
then

    export iNPRS=$iPRSn2
    export iSTOP=$iSTPn2
    export iRESUB=$iRSBn2
    export iCMPST=$compset2

    CASE_dir=${CASE_ROT}/${CASE_NAM2}
    CASE_bld=${CASE_OUT}/${CASE_NAM2}

    echo -e "\n---------------- 2. E3SM-bgc spin2: " ${CASE_dir}  $iCMPST "----------------"

    ########################################################
    echo -e "\n---------- 2.1 Create Case ---------\n"

    cd ${SRC_DIR}/cime/scripts

    rm -r ${CASE_dir}
    rm -r ${CASE_bld}
    ./create_newcase -case ${CASE_dir} \
    -compset ${iCMPST} -res ${RESOLUT}  -mach ${MACHINE} -project ${PROJECT} -compiler ${COMPILER}
    echo -e "\n-- RES " ${RESOLUT} " -- COMPSET " ${iCMPST} "\n"


    ########################################################
    echo -e "\n---------- 2.2 setup Case ---------\n"

    cd ${CASE_dir}

    ./xmlchange -file env_workflow.xml JOB_WALLCLOCK_TIME="96:00:00"
    ./xmlchange --force -file env_workflow.xml JOB_QUEUE=slurm
    #./xmlchange -file env_workflow.xml JOB_WALLCLOCK_TIME="2:00:00"
    #./xmlchange --force -file env_workflow.xml JOB_QUEUE=short

    ./xmlchange -file env_mach_pes.xml -id NTASKS_LND -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ATM -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_CPL -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ROF -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ICE -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_OCN -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_GLC -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_WAV -val ${iNPRS}
    ./xmlchange -file env_mach_pes.xml -id NTASKS_ESP -val ${iNPRS}

    ./xmlchange MAX_TASKS_PER_NODE=40
    ./xmlchange MAX_MPITASKS_PER_NODE=40
    ./xmlchange -file env_mach_pes.xml -id NTHRDS -val 4
    ./xmlquery MAX_TASKS_PER_NODE,NTASKS_LND,NTASKS_ATM,NTASKS_CPL,NTHRDS,MAX_MPITASKS_PER_NODE

    ./xmlchange DATM_CLMNCEP_YR_START=1960
    ./xmlchange DATM_CLMNCEP_YR_END=1962
    ./xmlchange DATM_CLMNCEP_YR_ALIGN=1960

    ./xmlchange -file env_run.xml -id STOP_N -val $iSTOP
    ./xmlchange -file env_run.xml -id REST_N -val 40
    ./xmlchange -file env_run.xml -id STOP_OPTION -val nyears
    ./xmlchange -file env_run.xml -id RESUBMIT -val $iRESUB
    ./xmlchange -file env_run.xml -id CONTINUE_RUN -val FALSE
    ./xmlchange -file env_run.xml -id RUN_STARTDATE -val 0001-01-01
    ./xmlchange -file env_run.xml -id SAVE_TIMING_DIR -val ${CASE_dir}
    #./xmlchange -file env_run.xml -id ELM_BLDNML_OPTS -val "-bgc bgc -nutrient cnp -nutrient_comp_pathway rd  -soil_decomp ctc -methane"

    # add by LLC
    ./xmlchange DATM_MODE=CLM_QIAN
    ./xmlchange -file env_run.xml -id DOUT_S_SAVE_INTERIM_RESTART_FILES -val TRUE
    ./xmlchange -file env_run.xml -id DOUT_S -val FALSE
    ./xmlchange -file env_run.xml -id BARRIER_OPTION -val never
    #./xmlchange -file env_run.xml -id DOUT_S_ROOT -val '$CASE_ROT/run'
    ./xmlchange -file env_run.xml -id RUNDIR -val ${CASE_dir}/run

    ./xmlchange LND_DOMAIN_PATH=/qfs/people/lili400/compy/project/ICoM/ELM-BGC/data/surface_data/elm_6km,LND_DOMAIN_FILE=domain_ICoM_6km_1D.nc
    ./xmlchange ATM_DOMAIN_PATH='$LND_DOMAIN_PATH',ATM_DOMAIN_FILE='$LND_DOMAIN_FILE'
    ./xmlquery LND_DOMAIN_PATH,LND_DOMAIN_FILE,ATM_DOMAIN_PATH,ATM_DOMAIN_FILE

    ./xmlchange ELM_CO2_TYPE=constant
    ./xmlchange CCSM_CO2_PPMV=317.04
    ./xmlquery ELM_CO2_TYPE,CCSM_CO2_PPMV

    # ./xmlchange LND_DOMAIN_PATH=/qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/0.0_data_pros/1.a_test_data,LND_DOMAIN_FILE=domain_test_8th.nc

    echo -e "\n---------- 1.3 setup user_nl ---------\n"
cat >> user_nl_elm <<EOF
hist_mfilt = 1
hist_nhtfrq = -175200
hist_fincl1 = 'PFT_CTRUNC'

finidat = '${CASE_ROT}/${CASE_NAM1}/run/${CASE_NAM1}.elm.r.0501-01-01-00000.nc'
fsurdat = '/qfs/people/lili400/compy/project/ICoM/ELM-BGC/data/surface_data/elm_6km/surfdata_ICoM_6km_1D.nc'
flanduse_timeseries = ''
stream_year_first_ndep = 1961
stream_year_last_ndep  = 1961

fsoilordercon = '/compyfs/tanz151/user_inputdata/lnd/clm2/paramdata/CNP_ctc_parameters.nc'
stream_fldfilename_ndep = '/compyfs/inputdata/lnd/clm2/ndepdata/fndep_clm_rcp4.5_simyr1849-2106_1.9x2.5_c100428.nc'
co2_file  = '/compyfs/inputdata/atm/datm7/CO2/fco2_datm_rcp4.5_1765-2500_c130312.nc'
aero_file = '/compyfs/inputdata/atm/cam/chem/trop_mozart_aero/aero/aerosoldep_rcp4.5_monthly_1849-2104_1.9x2.5_c100402.nc'
paramfile = '/compyfs/tanz151/user_inputdata/lnd/clm2/paramdata/clm_params.ctc.erosion.nc'

co2_ppmv = 317.04

suplphos = 'NONE'
use_dynroot = .false.
!use_nitrif_denitrif = .true.
use_lch4 = .true.
use_nofire= .true.

EOF

cat  >> user_nl_mosart <<EOF
do_rtm = .false.
inundflag = .false.
opt_elevprof = 1

frivinp_rtm = '/compyfs/xudo627/new_mesh/inputdata/MOSART_Mid-Atlantic_MPAS_c220107.nc'
!frivinp_rtm = '/compyfs/lili400/project/HighR/data/mosart/NLDAS_mosart_8th_202102.nc'

!rtmhist_nhtfrq= 0,-3
!rtmhist_mfilt = 1, 8
!rtmhist_fincl1='OUTLETG','FLOODED_FRACTION','FLOODPLAIN_FRACTION','FLOODPLAIN_VOLUME','QSUR_LIQ','QSUB_LIQ','QGWL_LIQ','STORAGE_LIQ','Main_Channel_STORAGE_LIQ','RIVER_DISCHARGE_OVER_LAND_LIQ','RIVER_DISCHARGE_TO_OCEAN_LIQ'
!rtmhist_fincl2='OUTLETG','FLOODED_FRACTION','FLOODPLAIN_FRACTION','FLOODPLAIN_VOLUME','QSUR_LIQ','QSUB_LIQ','QGWL_LIQ','STORAGE_LIQ','Main_Channel_STORAGE_LIQ','RIVER_DISCHARGE_OVER_LAND_LIQ','RIVER_DISCHARGE_TO_OCEAN_LIQ'

EOF

cat >> user_nl_datm << EOF
mapalgo = "nn", "nn", "nn"
EOF

    echo -e "-- 1.4 update: datm.streams --"
    ./case.setup
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.Precip_1960-1962 ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.Precip
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.Solar_1960-1962  ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.Solar
    cp /qfs/people/lili400/compy/project/ICoM/ELM-BGC/script/1.0_set_run/0.0_user_nl_datm/user_datm.streams.txt.CLM_QIAN.TPQW_1960-1962   ${CASE_dir}/user_datm.streams.txt.CLM_QIAN.TPQW

    echo -e "\n---------- 5. build Case ---------\n"
    ./case.setup
    ./case.build
    ./case.submit

    exit
fi

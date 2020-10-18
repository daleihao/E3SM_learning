%%%%%%%%%%%%%% 0.25
# cori-knl  r0125_r0125
# half Hourly 1 degree
## notpo
export RES=CLM_USRDAT
export COMPSET=ICLM45
export COMPILER=intel
export MACH=cori-knl
export CASE_NAME=10years_CLMGSWP3v1_notop.r025_r025.${COMPSET}.${COMPILER}

cd ~/model/e3sm_top/cime/scripts
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project m3520
cd ${CASE_NAME}

./xmlchange NTASKS=512,STOP_N=1,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="20:00:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=nyears,RESUBMIT=10
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

./xmlchange LND_DOMAIN_FILE=domain_global_0.25_c200913.nc 
./xmlchange ATM_DOMAIN_FILE=domain_global_0.25_c200913.nc 
./xmlchange LND_DOMAIN_PATH=/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data 
./xmlchange ATM_DOMAIN_PATH=/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
fsurdat = '/global/u2/d/daleihao/model/data/UCLA_3D_Topo_Data/surfdata_global_0.25_c200914.nc'
hist_empty_htapes = .true.
hist_fincl1 = 'COSZEN', 'ALBD', 'ALBI','FSA','FSR','FSDSND','FSDSNI','FSRND','FSRNI','FSDSVD','FSDSVI','FSRVD','FSRVI','FIRE'
hist_fincl2 = 'FSA','FSDS','FSR','FIRA','FIRE','FLDS','FGR','FSH','EFLX_LH_TOT','TSOI_10CM','TG','TV','TSA','QSNOMELT','QRUNOFF','QOVER','PSNSUN','PSNSHA','FPSN','FSNO','SNOWDP','H2OSNO'
hist_nhtfrq = 1, -24
hist_mfilt  = 48, 1
EOF

cp CaseDocs/datm.streams.txt.CLMGSWP3v1.Solar  user_datm.streams.txt.CLMGSWP3v1.Solar
cp CaseDocs/datm.streams.txt.CLMGSWP3v1.Precip  user_datm.streams.txt.CLMGSWP3v1.Precip
cp CaseDocs/datm.streams.txt.CLMGSWP3v1.TPQW  user_datm.streams.txt.CLMGSWP3v1.TPQW

./case.setup
./case.build
./case.submit
echo success



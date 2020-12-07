# EnergyFluxType add SH and LH  compared with EFLX_LH_TOT and Qh

  this%eflx_sh_tot_patch(begp:endp) = spval
    call hist_addfld1d (fname='SH_pft', units='unitless',  &
         avgflag='A', long_name='patch total sensible heat flux (W/m**2) [+ to atm]', &
         ptr_patch=this%eflx_sh_tot_patch, default='inactive')
		 
	this%eflx_lh_tot_patch(begp:endp) = spval
    call hist_addfld1d (fname='LH_pft', units='unitless',  &
         avgflag='A', long_name='patch total latent heat flux (W/m**2) [+ to atm]', &
         ptr_patch=this%eflx_lh_tot_patch, default='inactive')
	 
	 
	 
 # Script
export RES=CLM_USRDAT
export COMPSET=ICLM45 
export COMPILER=intel 
export MACH=compy 
export CASE_NAME=TEST2_LH_${RES}.${COMPSET}.${COMPILER}
cd ~/e3sm_top/cime/scripts 
./create_newcase -compset ICLM45 -res ${RES} -case ${CASE_NAME} -compiler ${COMPILER} -mach ${MACH} -project ESMD 
cd ${CASE_NAME}
./xmlchange LND_DOMAIN_FILE=domain_ARM_SGP_c201206.nc 
./xmlchange ATM_DOMAIN_FILE=domain_ARM_SGP_c201206.nc 
./xmlchange LND_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/clm-netcdf 
./xmlchange ATM_DOMAIN_PATH=/qfs/people/haod776/script_for_clm_sparse_grid/clm-netcdf

./xmlchange NTASKS=1,STOP_N=3,STOP_OPTION=ndays,JOB_WALLCLOCK_TIME="00:10:00",RUN_STARTDATE="2000-01-01",REST_N=1,REST_OPTION=ndays
./xmlchange DATM_MODE="CLMGSWP3v1",DATM_CLMNCEP_YR_START='2000',DATM_CLMNCEP_YR_END='2010'

cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'zeta_patch', 'ustar_patch', 'LH_pft', 'SH_pft',’TBOT’,’QBOT’,’RHO’,'EFLX_LH_TOT', 'Qh'
hist_fincl2 = 'FSH','EFLX_LH_TOT', 'Qh'
hist_nhtfrq = 1, -24
hist_mfilt  = 144, 3
hist_dov2xy = .false., .false.
hist_type1d_pertape = ' ', ' '
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/clm-netcdf/surfdata_ARM_SGP_c201206.nc'
EOF

./case.setup
./case.build
./case.submit



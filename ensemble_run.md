https://www.cesm.ucar.edu/models/cesm1.1/cesm/doc/usersguide/x851.html

set NINST

cat >> user_nl_clm_0001 << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'FV'
hist_fincl2 = 'FSH','EFLX_LH_TOT','Qh'
hist_nhtfrq = 1, -24
hist_mfilt  = 144, 3
hist_dov2xy = .false., .false.
hist_type1d_pertape = ' ', ' '
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/clm-netcdf/surfdata_ARM_SGP_c201206.nc'
EOF

cat >> user_nl_clm_0002 << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'zeta_patch'
hist_fincl2 = 'FSH','EFLX_LH_TOT','Qh'
hist_nhtfrq = 1, -24
hist_mfilt  = 144, 3
hist_dov2xy = .false., .false.
hist_type1d_pertape = ' ', ' '
fsurdat = '/qfs/people/haod776/script_for_clm_sparse_grid/clm-netcdf/surfdata_ARM_SGP_c201206.nc'
EOF

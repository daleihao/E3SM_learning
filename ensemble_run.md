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


set job_query
set ./xmlchange MAX_MPITASKS_PER_NODE=40
./xmlchange --force -file env_workflow.xml JOB_QUEUE=short
./xmlchange -file env_mach_pes.xml -id NTHRDS -val 2
./xmlchange -file env_mach_pes.xml -id CPL_NTHRDS -val 1



two different mechanism to do parallel work.  MPI uses distributed memory -- each MPI is basically its own e3sm.exe.  where openmp threads share memory.  you could run on one node of compy -- use 1 MPI.  Then run 1 MPI with 2 threads, then 4 threads, up to say 40 threads.  It should improve. But it will not scale great as only certain sections of our code has openmp pragams -- which tells the compiler to break up the work there.  But then to use more than 1 node, need somethign like MPI to communicate across network from node-to-node.  So we need MPI, but could have 1 MPI per node and then use threads within the node.  This would actually be optimum for memory use and is generally seen as best way -- it's just that our code just can't be threaded well enough for it to make sense.  So usually MPI is better for us, with some improvement using threads.

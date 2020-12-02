cat >> user_nl_clm << EOF
rad_3d_topo = .false.
f3dtopo = ''
hist_empty_htapes = .true.
hist_fincl1 = 'TG', 'FSH', 'Qh'
hist_fincl2 = 'TG', 'FSH', 'Qh'
hist_fincl3 = 'TG', 'FSH', 'Qh'
hist_fincl4 = 'TG', 'FSH', 'Qh'
hist_dov2xy = .true., .false., .false., .false.
hist_type1d_pertape = ' ', 'GRID', 'COLS', 'PFTS'
hist_nhtfrq = 1, 1, 1, 1
hist_mfilt  = 48, 48, 48, 48
EOF

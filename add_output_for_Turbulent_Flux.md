# EnergyFluxType add SH and LH  compared with EFLX_LH_TOT and Qh

  this%eflx_sh_tot_patch(begp:endp) = spval
    call hist_addfld1d (fname='SH_pft', units='unitless',  &
         avgflag='A', long_name='patch total sensible heat flux (W/m**2) [+ to atm]', &
         ptr_patch=this%eflx_sh_tot_patch, default='inactive')
		 
	this%eflx_lh_tot_patch(begp:endp) = spval
    call hist_addfld1d (fname='LH_pft', units='unitless',  &
         avgflag='A', long_name='patch total latent heat flux (W/m**2) [+ to atm]', &
         ptr_patch=this%eflx_lh_tot_patch, default='inactive')

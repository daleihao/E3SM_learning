# define index
  A variable naming convention has been adopted to help organize and identify the literally hundreds of state and flux fields managed by the Coupler. 
  
  State variable and flux variable
 
  example: index_l2x_Fall_lat for latent heat flux
 
  lnd_export: l2x(index_l2x_Fall_lat,i)    = -lnd2atm_vars%eflx_lh_tot_grc(g)

reference: https://www.cesm.ucar.edu/models/ccsm3.0/cpl6/users_guide/node12.html

# Change domainMOD.F90

add 3D-RT module

# Change namelist
clm namelist user_nl_clm

# Change clm_initializeMod.F90
Import topography parameters

# Change data_types TopounitType.F90


you can check if the model wrote any restart file, check in your run directory if *.clm2.r.*ncfile was written.
7:35
let me know if the restart wasn't written
7:36
btw, you can control the restart frequency output by changing REST_Nand REST_OPTION .


it is because the model did not run long enough to write a restart file.
2:27
resubmit the run with CONTINUE_RUN=.FALSE., but change REST_N and REST_OPTIONsuch that the model writes a restart file


./xmlchange REST_N=1,REST_OPTION=nmonths,CONTINUE_RUN=FALSE,STOP_N=3,STOP_OPTION=nmonths,RESUBMIT=3



https://www.cesm.ucar.edu/models/ccsm4.0/data8/c193.html#str_fillalgo
https://www.cesm.ucar.edu/models/cesm1.0/clm/models/lnd/clm/doc/UsersGuide/x7895.html

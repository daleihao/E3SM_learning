# remove files
    rm -r dir
    rm -rf dir
    rm filename
# change the permission of one file   
     chmod 644 user_datm.streams.txt
# ncdump 
    refer to https://www.unidata.ucar.edu/software/netcdf/workshops/2011/utilities/Ncdump.html
    ncdump -h # header
    ncdump -c # header and coordinate system
    ncdump -v lat,time # look at a subset of the data
    ncdump -t -v time # seetimes in human-readable form
# cp
    cp -f source dest  # copy file no prompt
    cp -r source dest  # copy all filres
# link files
    ln -s 
# sbalance check
    module load sbank
    sbank balance statement -A/-U
# rename
    for file in r0125*.mat; do mv $file ${file//r0125/r025}; done
# unzip
    unzip *.zip

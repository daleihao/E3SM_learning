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
    unzip *.zip tar -xvf *.tar.gz
# chmod
    chmod a+rwx (read, wrie, execute) (u, user; g, group; o, others; a, all)
# cat
## append
    cat > filename <<EOF
    EOF
## output to a file
    car >> filename <<EOF
    EOF
# basic operations
    export, whereis, which, clear, ls -l, toucch, cat, head, more, tail, mv, cp, rm, diff, chmod, gzip, gunzip, grep. nl, pwd, ssh, 
    
# download files
    #!/bin/bash
    #These lines are for Slurm
    #SBATCH -N 1
    #SBATCH -J MODIS_albedo
    #SBATCH -t  10000
    #SBATCH -A sif
    #SBATCH -o /pic/projects/sif/dalei/MODIS_Albedo/MODIS_albedo.out

    ##### These are shell commands
    cd /pic/projects/sif/dalei/MODIS_Albedo/
    wget -e robots=off -m -np -R .html,.tmp -nH --cut-dirs=3 "https://ladsweb.modaps.eosdis.nasa.gov/archive/orders/501280930/" --header "Authorization: Bearer 83EB74A6-4474-  11E8-A6D4-10FA569DBFBA" -P  /pic/projects/sif/dalei/MODIS_Albedo/
    #wget --http-user=haodl@radi.ac.cn --http-passwd=Hdl271818 -i download.txt

    echo finished!

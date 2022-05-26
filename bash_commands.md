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
    
    tar -xvf 
    gzip -d file.gz
    for year in {2000..2010}
    do
	    cd /global/cscratch1/sd/daleihao/e3sm_scratch/cori-knl/GlobSnow/www.globsnow.info/se/archive_v2.0/$year/MFSC/
	    gzip -dk *.gz
    done
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
    
  # check the quota
  
    As a user, you can see you usage and quota with a command like this.

    [tim@compy01 ~]$ lfs quota -hu tim /compyfs Disk quotas for usr tim (uid 20679):
        Filesystem    used   quota   limit   grace   files   quota   limit   grace
        /compyfs  5.477G      0k     30T       -       8       0       0       -

        Here you can see that I am using 5.5G out of my 30T quota.  While on the topic, remember that your home directory has a quota of 400GB which can be seen with a "df -h . " in your home directory

    [tim@compy01 ~]$ df -h .
    Filesystem      Size  Used Avail Use% Mounted on
    qfsi:/people    401G  214G  187G  54% /qfs/people

# squeue show full name
http://manpages.ubuntu.com/manpages/xenial/man1/squeue.1.html
 squeue -u daleihao -o "%30j, %30F, %L, %l, %T"

# SCP
scp -r -i ~/.ssh/nersc daleihao@dtn01.nersc.gov:/global/project/projectdirs/m3520/share/cesm_inputdata/aero_deposit_data/  ./
#!/bin/zsh
#SBATCH -N 1
#SBATCH -t 3000
#SBATCH -p slurm
#SBATCH -J a
#SBATCH -o a.out


cd /compyfs/inputdata/atm/datm7/atm_forcing.SSP126.CESM.c220520
chmod a-w  chmod a-w  monthly_data/*.nc
scp -r -i ~/.ssh/nersc daleihao@dtn01.nersc.gov:/global/project/projectdirs/m3520/share/cesm_inputdata/ssp1/monthly_data  ./


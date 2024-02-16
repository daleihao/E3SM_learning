clc;
clear all;
close all;

Dir_save = './';
filename_ori = 'landuse.timeseries_ABOVE_025_SSP126_Demeter_c220328-001_r.nc';
filename_formatted = 'landuse_ABOVE_1850_2100_SSP126_Demeter_c240215.nc';

%% extract data from original data
lats = ncread(filename_ori,'LATIXY');
lons = ncread(filename_ori,'LONGXY');
lons = lons(:,1);
lons = lons - 360;
lats = squeeze(lats(1,:));
PCT_CROPs = ncread(filename_ori,'PCT_CROP');
PCT_CFTs = ncread(filename_ori,'PCT_CFT');
PCT_NAT_PFTs = ncread(filename_ori,'PCT_NAT_PFT');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%% save file
outputFileName = [Dir_save filename_formatted];

ncid = netcdf.create(outputFileName,'NETCDF4');
latdimid = netcdf.defDim(ncid,'lat',124);
londimid = netcdf.defDim(ncid,'lon',352);
timedimid = netcdf.defDim(ncid,'time',251);
nbndsdimid = netcdf.defDim(ncid,'nbnds',2);

cftdimid = netcdf.defDim(ncid,'cft',2);
natpftdimid = netcdf.defDim(ncid,'natpft',15);

%% creat global attribute
varid = netcdf.getConstant('GLOBAL');
netcdf.putAtt(ncid,varid,'institution','Department of Forest and Wildlife Ecology, University of Wisconsin-Madison, Madison, WI, USA');
netcdf.putAtt(ncid,varid,'creation_date', datestr(now));
netcdf.putAtt(ncid,varid,'version','v1.0');
netcdf.putAtt(ncid,varid,'reference',"Luo, M., Li, F., Hao, D., Zhu, Q., Dashti, H., & Chen, M. (2023). Uncertain spatial pattern of future land use and land cover change and its impacts on terrestrial carbon cycle over the Arctic–Boreal region of North America. Earth's Future, 11, e2023EF003648. https://doi.org/10.1029/2023EF003648");
netcdf.putAtt(ncid,varid,'title', '0.25° gridded land use and land cover change (LULCC) data from 1850-2100 over ABOVE domain');
netcdf.putAtt(ncid,varid,'source', 'Spaital downscaling from GCAM regional output, using Demeter model');


%% latitude
varid = netcdf.defVar(ncid,'lat','NC_FLOAT',[latdimid]);
netcdf.putVar(ncid,varid,lats);
netcdf.putAtt(ncid,varid,'units','degrees_north');
netcdf.putAtt(ncid,varid,'long_name','Latitude');
netcdf.putAtt(ncid,varid,'standard_name','latitude');

%% longitude
varid = netcdf.defVar(ncid,'lon','NC_FLOAT',[londimid]);
netcdf.putVar(ncid,varid,lons);
netcdf.putAtt(ncid,varid,'units','degrees_east');
netcdf.putAtt(ncid,varid,'long_name','Longitude');
netcdf.putAtt(ncid,varid,'standard_name','longitude');

%% time
times = [0:250];
varid = netcdf.defVar(ncid,'time','NC_SHORT',[timedimid]);
netcdf.putVar(ncid,varid,times);
netcdf.putAtt(ncid,varid,'units','years since 1850-01-01 00:00:00');
netcdf.putAtt(ncid,varid,'long_name','Time');
netcdf.putAtt(ncid,varid,'standard_name','time');
netcdf.putAtt(ncid,varid,'calendar','proleptic_gregorian');
netcdf.putAtt(ncid,varid,'bounds','time_bnds');

time_bnds = [0:250; 0:250];
time_bnds = time_bnds';
varid = netcdf.defVar(ncid,'time_bnds','NC_SHORT',[timedimid nbndsdimid]);
netcdf.putVar(ncid,varid,time_bnds);
netcdf.putAtt(ncid,varid,'units','years since 1850-01-01 00:00:00');
netcdf.putAtt(ncid,varid,'long_name','start and end points of each time step');
netcdf.putAtt(ncid,varid,'calendar','proleptic_gregorian');

%% cft
cfts = [15 16];
varid = netcdf.defVar(ncid,'cft','NC_SHORT',[cftdimid]);
netcdf.putVar(ncid,varid,cfts);
netcdf.putAtt(ncid,varid,'units','unitless; index');
netcdf.putAtt(ncid,varid,'long_name','indices of CFTs');
netcdf.putAtt(ncid,varid,'standard_name','cft');

%% natpft
natpfts = 0:14;
varid = netcdf.defVar(ncid,'natpft','NC_SHORT',[natpftdimid]);
netcdf.putVar(ncid,varid,natpfts);
netcdf.putAtt(ncid,varid,'units','unitless; index');
netcdf.putAtt(ncid,varid,'long_name','indices of natural PFTs');
netcdf.putAtt(ncid,varid,'standard_name','natpft');

%% PCT_NAT_PFT
varid = netcdf.defVar(ncid,'PCT_NAT_PFT','NC_FLOAT',[londimid latdimid natpftdimid timedimid]);
netcdf.defVarFill(ncid, varid, false, -9999);
netcdf.defVarChunking(ncid,varid,'CHUNKED',[352 124 15 251]);
netcdf.defVarDeflate(ncid,varid,true,true,2);
netcdf.putVar(ncid,varid,PCT_NAT_PFTs);
% add attribute
netcdf.putAtt(ncid,varid,'Unit','%');
netcdf.putAtt(ncid,varid,'long_name','percent plant functional type on the natural veg landunit (% of landunit)');
netcdf.putAtt(ncid,varid,'standard_name','PCT_NAT_PFT');

%% PCT_CFT
varid = netcdf.defVar(ncid,'PCT_CFT','NC_FLOAT',[londimid latdimid cftdimid timedimid]);
netcdf.defVarFill(ncid, varid, false, -9999);
netcdf.defVarChunking(ncid,varid,'CHUNKED',[352 124 2 251]);
netcdf.defVarDeflate(ncid,varid,true,true,2);
netcdf.putVar(ncid,varid,PCT_CFTs);
% add attribute
netcdf.putAtt(ncid,varid,'Unit','%');
netcdf.putAtt(ncid,varid,'long_name','percent crop functional type on the crop landunit (% of landunit)');
netcdf.putAtt(ncid,varid,'standard_name','PCT_CFT');


%% PCT_CROP
varid = netcdf.defVar(ncid,'PCT_CROP','NC_FLOAT',[londimid latdimid timedimid]);
netcdf.defVarFill(ncid, varid, false, -9999);
netcdf.defVarChunking(ncid,varid,'CHUNKED',[352 124 251]);
netcdf.defVarDeflate(ncid,varid,true,true,2);
netcdf.putVar(ncid,varid,PCT_CROPs);
% add attribute
netcdf.putAtt(ncid,varid,'Unit','%');
netcdf.putAtt(ncid,varid,'long_name','total percent crop landunit');
netcdf.putAtt(ncid,varid,'standard_name','PCT_CROP');

%% close
netcdf.close(ncid);


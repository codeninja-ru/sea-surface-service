# /bin/sh
DATE=`date -u -v-1d "+%Y%m%d"`
URL="ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/sst.$DATE/sst2dvar_grb_0.5.grib2"

rm sst2dvar_grb_0.5.grib2
wget $URL -O sst2dvar_grb_0.5.grib2 

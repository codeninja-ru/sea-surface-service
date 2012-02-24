# /bin/sh
DATE=`date -u -v-1d "+%Y%m%d"`
URL="ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/sst.$DATE/sst2dvar_grb_0.5.grib2"

rm sst2dvar_grb_0.5.grib2
wget $URL -O sst2dvar_grb_0.5.grib2 

wgrib2 sst2dvar_grb_0.5.grib2 -csv sst.csv

ruby parse.rb
mongoimport -d weather -c sea --upsert --type csv --headerline --file mongo_sst_dump.csv

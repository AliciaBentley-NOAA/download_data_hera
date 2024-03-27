; ===========================================
; Download GFS analysis files from HPSS
; Created by: Alicia M. Bentley
; ===========================================
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/ut_string.ncl"
; ===========================================

begin

print(" ")
print("**************")
print(" START SCRIPT ")
print("**************")

;*******************************************************
; Define what dates to download
;*******************************************************

iyyyy = 2024		; Define initialization date (yyyy mm dd hh)
imm = 3
idd = 1
ihh = 0

timeUnits = "hours since 1800-01-01 00:00:00"
bdate = cd_inv_calendar(iyyyy,imm,idd,ihh,00,00,timeUnits,0)
        byyyy = ut_string(bdate,"%Y")                            ; Determine year of current date in yyyy form
        bmm = ut_string(bdate,"%N")
        bdd = ut_string(bdate,"%D")
        bhh = ut_string(bdate,"%H")


print(" ")
print("bdate: "+ut_string(bdate,""))
print(" ")

do fhr_loop = 0,744,24       ; Download forecast files from F000 to F144 hours at 12-hour increments 

cdate = bdate
cdate = bdate + fhr_loop
        cyyyy = ut_string(cdate,"%Y")                            ; Determine year of current date in yyyy form
        cmm = ut_string(cdate,"%N")
        cdd = ut_string(cdate,"%D")
        chh = ut_string(cdate,"%H")

print("Downloading GFS analysis for: "+ut_string(cdate,""))

; ******************************************************
; Download files
; ******************************************************

; This section should be used to download GFS v16.2 forecasts after 2021031812 and before 2022062700
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_prod_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_prod_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")


; This section should be used to download GFS v16.2 forecasts after 2022062700 and before 2022112900
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")


; This section should be used to download GFS v16.3 forecasts after 2022112900
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_v16.3_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.1p00.anl")
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_v16.3_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.1p00.anl")

;-------------------------------------------------------------------

gfsanl = "gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.1p00.anl"
print("gfsanl: "+gfsanl)

dq = str_get_dq()

system("rm -rf gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")
system("> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")

system("wgrib2 -match "+dq+"HGT:500 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")

system("wgrib2 -match "+dq+"TMP:850 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")

system("wgrib2 -match "+dq+"UGRD:200 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")
system("wgrib2 -match "+dq+"VGRD:200 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")
system("wgrib2 -match "+dq+"UGRD:850 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")
system("wgrib2 -match "+dq+"VGRD:850 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")

system("wgrib2 -match "+dq+"UGRD:10 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")
system("wgrib2 -match "+dq+"UGRD:30 mb"+dq+" "+gfsanl+"|wgrib2 -i "+gfsanl+" -grib retriev")
system("cat retriev >> gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs."+cyyyy+cmm+cdd+chh+".anl")

system("rm -rf "+gfsanl) 

exit

end do     ; end fhr_loop

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

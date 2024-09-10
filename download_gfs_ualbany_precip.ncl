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
imm = 6
idd = 21
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

do fhr_loop = 0,18,6       ; Download forecast files from F000 to F144 hours at 12-hour increments 

cdate = bdate
cdate = bdate + fhr_loop
        cyyyy = ut_string(cdate,"%Y")                            ; Determine year of current date in yyyy form
        cmm = ut_string(cdate,"%N")
        cdd = ut_string(cdate,"%D")
        chh = ut_string(cdate,"%H")

print(" ")
print("Downloading GFS analysis for: "+ut_string(cdate,""))
print("chh: "+chh)

; ******************************************************
; Download files
; ******************************************************

; This section should be used to download old GFS forecasts after 2021031812 and before 2022062700
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_prod_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.0p25.anl")
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_prod_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.0p25.anl")

; This section should be used to download GFS v16.2 forecasts after 2022062700 and before 2022112900
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.1p00.anl")


; This section should be used to download GFS v16.3 forecasts after 2022112900
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_v16.3_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.0p50.f006")
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+cyyyy+"/"+cyyyy+cmm+"/"+cyyyy+cmm+cdd+"/com_gfs_v16.3_gfs."+cyyyy+cmm+cdd+"_"+chh+".gfs_pgrb2.tar ./gfs."+cyyyy+cmm+cdd+"/"+chh+"/atmos/gfs.t"+chh+"z.pgrb2.0p50.f006")

;-------------------------------------------------------------------

end do     ; end fhr_loop

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

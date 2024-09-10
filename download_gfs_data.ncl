; ===========================================
; DOwnload GFS forecasts from HPSS
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
idd = 29
ihh = 12

timeUnits = "hours since 1800-01-01 00:00:00"
bdate = cd_inv_calendar(iyyyy,imm,idd,ihh,00,00,timeUnits,0)
        byyyy = ut_string(bdate,"%Y")                            ; Determine year of current date in yyyy form
        bmm = ut_string(bdate,"%N")
        bdd = ut_string(bdate,"%D")
        bhh = ut_string(bdate,"%H")


print(" ")
print("bdate: "+ut_string(bdate,""))
print(" ")

do fhr_loop = 0,120,12       ; Download forecast files from F000 to F144 hours at 12-hour increments 

cdate = bdate
cdate = bdate + fhr_loop
        cyyyy = ut_string(cdate,"%Y")                            ; Determine year of current date in yyyy form
        cmm = ut_string(cdate,"%N")
        cdd = ut_string(cdate,"%D")
        chh = ut_string(cdate,"%H")

; ******************************************************
; Load files
; ******************************************************
    print(" ")

                 if (fhr_loop.lt.10) then
                      filefhr := "00"+fhr_loop
                 else if ((fhr_loop.lt.100).and.(fhr_loop.gt.10)) then
                      filefhr := "0"+fhr_loop
                 else if (fhr_loop.gt.100) then
                      filefhr := fhr_loop
                 end if
                 end if
                 end if


; This section downloads data before the switch to WCOSS2
;print("filefhr: "+filefhr)
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_prod_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_prod_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)

; This section download GFS v16.2 forecasts
;print("filefhr: "+filefhr)
;print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.2_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)

; This section downloads GFS v16.3 forecasts
print("filefhr: "+filefhr)
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.3_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gfs_v16.3_gfs."+byyyy+bmm+bdd+"_"+bhh+".gfs_pgrb2.tar ./gfs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gfs.t"+bhh+"z.pgrb2.0p25.f"+filefhr)


end do     ; end fhr_loop

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

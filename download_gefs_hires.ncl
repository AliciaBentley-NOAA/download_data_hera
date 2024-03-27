; ===========================================
; Downloads GEFS mean/spread from HPSS
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
imm = 2
idd = 3
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

do fhr_loop = 0,384,12       ; Downloads forecast hours F000 to F120 at 24 h increments)

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


print("filefhr: "+filefhr)
; Download GEFS mean forecast files (note: 2a files, not 2b files)
print("htar -xvf /NCEPPROD/hpssprod/runhistory/5year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2sp25.tar ./atmos/pgrb2sp25/geavg.t"+bhh+"z.pgrb2s.0p25.f"+filefhr)
system("htar -xvf /NCEPPROD/hpssprod/runhistory/5year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2sp25.tar ./atmos/pgrb2sp25/geavg.t"+bhh+"z.pgrb2s.0p25.f"+filefhr)
system("mkdir -p gefs."+byyyy+bmm+bdd+"/"+bhh+"/atmos")
system("mv ./atmos/pgrb2sp25/geavg.t"+bhh+"z.pgrb2s.0p25.f"+filefhr+" ./gefs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/geavg.t"+bhh+"z.pgrb2s.0p25.f"+filefhr)

; Download GEFS spread forecast files (note: 2a files, not 2b files)
;print("htar -xvf /NCEPPROD/hp/hpssprod/runhistory/2year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2ap5.tar ./atmos/pgrb2ap5/gespr.t"+bhh+"z.pgrb2a.0p50.f"+filefhr)
;system("htar -xvf /NCEPPROD/hpssprod/runhistory/2year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2ap5.tar ./atmos/pgrb2ap5/gespr.t"+bhh+"z.pgrb2a.0p50.f"+filefhr)
;system("mv ./atmos/pgrb2ap5/gespr.t"+bhh+"z.pgrb2a.0p50.f"+filefhr+" ./gefs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/gespr.t"+bhh+"z.pgrb2a.0p50.f"+filefhr)


end do     ; end fhr_loop

system("rm -rf atmos/")

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

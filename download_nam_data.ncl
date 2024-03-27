; ===========================================
; Download NAM forecasts from HPSS
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

iyyyy = 2024		; Define first date to plot (yyyy mm dd hh)
imm = 2
idd = 13
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

do fhr_loop = 0,72,6       ; Create images from start date to end date (with 6 h increments)

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
                      filefhr := "0"+fhr_loop
                 else if ((fhr_loop.lt.100).and.(fhr_loop.gt.10)) then
                      filefhr := fhr_loop
                 else if (fhr_loop.gt.100) then
                      filefhr := fhr_loop
                 end if
                 end if
                 end if


print("filefhr: "+filefhr)
system("mkdir nam."+byyyy+bmm+bdd)
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_nam_v4.2_nam."+byyyy+bmm+bdd+bhh+".awip32.tar ./nam.t"+bhh+"z.awip32"+filefhr+".tm00.grib2")
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_nam_v4.2_nam."+byyyy+bmm+bdd+bhh+".awip32.tar ./nam.t"+bhh+"z.awip32"+filefhr+".tm00.grib2")
system("mv ./nam.t"+bhh+"z.awip32"+filefhr+".tm00.grib2 nam."+byyyy+bmm+bdd+"/.")

end do     ; end fhr_loop

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

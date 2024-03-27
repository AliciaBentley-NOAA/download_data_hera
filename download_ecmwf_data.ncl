; ===========================================
; Downloads ECMWF forecasts from HPSS
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

do fhr_loop = 0,120,6       ; Create images from start date to end date (with 6-h increments)

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

system("mkdir -p ecmwf."+byyyy+bmm+bdd+"/"+bhh)

if fhr_loop .eq. 0 then
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/dcom_"+byyyy+bmm+bdd+".tar ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"011")
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/dcom_"+byyyy+bmm+bdd+".tar ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"011")
;system("mv ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"011 ./ecmwf."+byyyy+bmm+bdd+"/"+bhh+"/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"011")
else
print("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/dcom_"+byyyy+bmm+bdd+".tar ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"001")
system("htar -xvf /NCEPPROD/hpssprod/runhistory/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/dcom_"+byyyy+bmm+bdd+".tar ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"001")
;system("mv ./wgrbbul/ecmwf/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"001 ./ecmwf."+byyyy+bmm+bdd+"/"+bhh+"/U1D"+bmm+bdd+bhh+"00"+cmm+cdd+chh+"001")
end if 

end do     ; end fhr_loop

system("mv wgrbbul/ecmwf/* ecmwf."+byyyy+bmm+bdd+"/"+bhh+"/.")

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

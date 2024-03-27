; ===========================================
; Download individual GEFS members from HPSS
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

iyyyy = 2024		; Define forecast initialization date (yyyy mm dd hh)
imm = 2
idd = 10
ihh = 0

vyyyy = 2024            ; Define valid date that you want to look at (yyyy mm dd hh)
vmm = 2
vdd = 16
vhh = 0

timeUnits = "hours since 1800-01-01 00:00:00"
bdate = cd_inv_calendar(iyyyy,imm,idd,ihh,00,00,timeUnits,0)
        byyyy = ut_string(bdate,"%Y")                            ; Determine year of current date in yyyy form
        bmm = ut_string(bdate,"%N")
        bdd = ut_string(bdate,"%D")
        bhh = ut_string(bdate,"%H")

vdate = cd_inv_calendar(vyyyy,vmm,vdd,vhh,00,00,timeUnits,0)
leadtime = vdate-bdate

print(" ")
print("bdate: "+ut_string(bdate,""))
print("vdate: "+ut_string(vdate,""))
print("leadtime: "+leadtime)
print(" ")

do fhr_loop = leadtime,leadtime,24       ; Download files from first initization date to valid date (at 24 h increments)

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

do member = 0,30,1

       if member .eq. 0 then
          mem_name = "gec00"
       else
          if member .le. 9 then
             mem_name = "gep0"+member
          else if member .ge. 10 then
             mem_name = "gep"+member
          end if
          end if
;          print("mem_name: "+mem_name)
       end if

; Downloads 0.5-deg ensemble members (note: only 2a, not 2b)
print("htar -xvf /NCEPPROD/hpssprod/runhistory/2year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2ap5.tar ./atmos/pgrb2ap5/"+mem_name+".t"+bhh+"z.pgrb2a.0p50.f"+filefhr)
system("htar -xvf /NCEPPROD/hpssprod/runhistory/2year/rh"+byyyy+"/"+byyyy+bmm+"/"+byyyy+bmm+bdd+"/com_gefs_v12.3_gefs."+byyyy+bmm+bdd+"_"+bhh+".atmos_pgrb2ap5.tar ./atmos/pgrb2ap5/"+mem_name+".t"+bhh+"z.pgrb2a.0p50.f"+filefhr)

system("mkdir -p gefs."+byyyy+bmm+bdd+"/"+bhh+"/atmos")
system("mv ./atmos/pgrb2ap5/"+mem_name+".t"+bhh+"z.pgrb2a.0p50.f"+filefhr+" ./gefs."+byyyy+bmm+bdd+"/"+bhh+"/atmos/"+mem_name+".t"+bhh+"z.pgrb2a.0p50.f"+filefhr)

end do     ; member

end do     ; end fhr_loop

system("rm -rf atmos/")

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end

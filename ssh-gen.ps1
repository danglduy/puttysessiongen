$sessionname = Read-Host 'Your session name'
$sessionname.replace(' ','') *>&1 | out-null
$IP = Read-Host 'IP'
$IP.replace(' ','') *>&1 | out-null


### Edit your variable here
# The path to putty session registry file folder.
# This is also the location of default.reg.
$regpath = $(pwd).Path
# The path to putty.exe file
$puttypath = $(pwd).Path+'\putty.exe'
# The path to for your result session files.
$puttysshpath = $(pwd).Path
# Private key file name
$privatekeyname = 'private.ppk'
# The path to private key (.ppk) of the session
$privatekeypath = $(pwd).Path+'\'+$privatekeyname
### END


# The path to putty session default template file.
$defaultreg = $regpath+'\default.reg'
# The path to putty session customized reg file.
$sessionreg = $regpath+'\'+$sessionname+'.reg'

### Do not edit below
$privatekeypath.replace('\','\\') *>&1 | out-null

(Get-Content $defaultreg)  | Foreach-Object { $_ -replace '\$IP',$IP`
                                                 -replace '\$sessionname',$sessionname`
                                                 -replace '\$privatekeypath',$privatekeypath
                                            } > $sessionreg

Reg Import $sessionreg *>&1 | out-null
Remove-Item -Path $sessionreg 
$puttysshcontent = 'start '+$puttypath+' -ssh -load "'+$sessionname+'"'
$puttysshfile = $puttysshpath+'\'+$sessionname + '.cmd'
$puttysshcontent | Out-File -encoding ASCII $puttysshfile

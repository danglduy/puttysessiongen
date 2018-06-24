$sessionname = Read-Host 'Your session name'
$IP = Read-Host 'IP'
$IP = $IP.replace(' ','')


### Edit your variable here
# The path to putty session registry file folder.
# This is also the location of default.reg.
$regpath = $(pwd).Path
# The path to putty.exe file
$puttypath = $(pwd).Path+'\inc\putty.exe'
# The path to for your result session run files.
$puttysshpath = $(pwd).Path+'\sessions'

# Private key file name
$privatekeyname = 'private.ppk'
# The path to private key (.ppk) of the session
$privatekeypath = $(pwd).Path+'\inc\'+$privatekeyname
### END


# The path to putty session default template file.
$defaultreg = $regpath+'\inc\default.reg'
# The path to putty session customized reg file.
$sessionreg = $regpath+'\'+$sessionname+'.reg'

### Do not edit below
$privatekeypath = $privatekeypath.replace('\','\\')

# Create sessions folder if not exist
If(!(Test-Path $puttysshpath))
{
      New-Item -ItemType Directory -Force -Path $puttysshpath
}
(Get-Content $defaultreg)  | Foreach-Object { $_ -replace '\$IP',$IP`
                                                 -replace '\$sessionname',$sessionname`
                                                 -replace '\$privatekeypath',$privatekeypath
                                            } > $sessionreg

Reg Import $sessionreg *>&1 | out-null
# Remove session reg file after importing to registry.
Remove-Item -Path $sessionreg 
# Create session run file
$puttysshcontent = 'start '+$puttypath+' -ssh -load "'+$sessionname+'"'
$puttysshfile = $puttysshpath+'\'+$sessionname + '.cmd'
$puttysshcontent | Out-File -encoding ASCII $puttysshfile

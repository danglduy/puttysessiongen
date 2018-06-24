# Remove all sessions, be careful
Remove-Item -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\ -Recurse *>&1 | out-null
# Remove all session run files
$path = $(pwd).Path+'\sessions'+'\*.cmd'
Remove-Item -Path $path

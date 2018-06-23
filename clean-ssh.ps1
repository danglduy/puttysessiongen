# Remove all sessions, be careful
Remove-Item -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\ -Recurse *>&1 | out-null
# Remove all session run files
Remove-Item -Path $(pwd).Path+'\*.cmd'
Remove-Item -Path $(pwd).Path+'\*.bat'
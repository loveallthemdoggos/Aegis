foreach ($getprofile in (get-ciminstance win32_userprofile -Filter "Special=$false" | Select-Object lastusetime, localpath, sid)) {

    foreach ($profile in $getprofile) {
    
        $usersid = $profile.sid
        $userlastuse = $profile.lastusetime
        $userlocalpath = $profile.localpath
        $userfoldersize = ((Get-ChildItem $getprofile.localpath -Recurse | Where-Object { -not $_.PSIsContainer } | Measure-Object -Property Length -Sum).Sum / 1GB)
        $userfoldersizerounded = ([Math]::Round($userfoldersize, 2))
        $getfullname = (Get-CimInstance Win32_UserAccount | Where-Object sid -like "$usersid")
        $userfullname = $getfullname.FullName
        }
    
       Write-Output "$userfullname, $userfoldersizerounded GB, $userlastuse, $userlocalpath"
    }
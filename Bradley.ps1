foreach ($getprofile in (get-ciminstance Win32_UserProfile | Select-Object lastusetime, localpath, sid)) {

    foreach ($profile in $getprofile) {
    
        $usersid = $getprofile.sid
        $objSID = New-Object System.Security.Principal.SecurityIdentifier($usersid)
        $userfullname = $objSID.Translate([System.Security.Principal.NTAccount])
        $userfoldersize = ((Get-ChildItem $getprofile.localpath -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB)
        $userfoldersizerounded = ([Math]::Round($userfoldersize, 2))
        }
        
    }

    Write-Output "$userfullname $userfoldersizerounded $profile"
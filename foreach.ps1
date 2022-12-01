#its returning the items from the first foreach loop as an array
# then appending the value I wanted as a string to the end

foreach ($getprofile in (get-ciminstance Win32_UserProfile -Filter "Special = $false" | Select-Object lastusetime, localpath, sid)) {

    foreach ($profile in $getprofile) {
    
        $usersid = $getprofile.sid
        $objSID = New-Object System.Security.Principal.SecurityIdentifier($usersid)
        $userfullname = $objSID.Translate([System.Security.Principal.NTAccount])
        $userfoldersize = ((Get-ChildItem $getprofile.localpath -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB)
        $userfoldersizerounded = ([Math]::Round($userfoldersize, 2))
        }
    
    } 
# $getfullname = (Get-CimInstance Win32_UserAccount | Select-Object FullName, SID)
# $userfullname = $getfullname.FullName

Write-Output "$userfullname + $userfoldersizerounded $profile"
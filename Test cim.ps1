$getfullname = (Get-CimInstance Win32_UserAccount | Select-Object FullName)
$getfullname.foreach({

        $userfullname = $getfullname.FullName
        Write-Output "$userfullname"
})


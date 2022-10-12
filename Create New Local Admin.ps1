$creds = Get-Credential

New-LocalUser $creds.UserName -Password $creds.Password -FullName $creds.UserName -Description $creds.UserName
Add-LocalGroupMember -Group "Administrators" -Member $creds.UserName
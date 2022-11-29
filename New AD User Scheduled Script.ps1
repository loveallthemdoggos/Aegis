# This script is designed to import user information from a csv file and create an
# Active Directory User Account based on the information in the csv.

$Path = "\\WIN-S7ER04SH50E\Share"
$PathFile = "\\WIN-S7ER04SH50E\Share\New User.csv"

# Tests path to see if file exists
$TestPath = Test-Path -Path $Path
if ($TestPath -eq $false)
    {exit}

# Import active directory module for running AD cmdlets
Import-Module activedirectory

#Store the data from New User.Csv in the $ADUsers variable
$ADUsers = Import-Csv -Path $PathFile

$ADUsers | ConvertFrom-Csv

#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
    #Read user data from each field in each row and assign the data to a variable as below

    #Check to see if the user already exists in AD
    if (Get-ADUser -Filter "SamAccountName -eq '$($User.username)'")
    {
        #If user does exist, exit
        exit
    }
    else
    {
        #User does not exist then proceed to create the new user account
        #Account will be created in the OU provided by the $OU variable read from the CSV file
        $NewUserSplat = @{
            GivenName             = $user.FirstName
            Surname               = $user.LastName
            DisplayName           = "$($user.FirstName) $($user.LastName)"
            Office                = $user.Location
            Email                 = $user.Email
            OfficePhone           = $user.PhoneNumber
            userPrincipalName     = $user.UserName
            Name                  = "$($user.FirstName) $($user.LastName)"
            Enabled               = $True
            Description           = $user.JobTitle
            SamAccountName        = $user.Username
            Path                  = "OU=$($user.Location),DC=at1024,DC=com"
            AccountPassword       = (ConvertTo-SecureString $user.Password -AsPlainText -Force)
            
        }
        New-ADUser @NewUserSplat
               
    }
    $groups = $user.Group

        foreach($group in $groups.split(';'))
            {
                Add-ADGroupMember -Identity $group -Members $user.Username
            }
}

Remove-Item -Path $PathFile -Force

Start-ADSyncSyncCycle -PolicyType Delta
#region module 1
# Write-Output "Hello World $env:USERNAME"
#endregion

# Write-Output "Hello`nWorld"

Param(
    [string]$computername = $env:computername)
    Get-CimInstance -ClassName CIM_ComputerSystem `
        -ComputerName $computername |
        Format-List numberofprocessors,totalphysicalmemory

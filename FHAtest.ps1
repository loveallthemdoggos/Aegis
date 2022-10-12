$Contacts = Import-Csv 'C:\Users\ackermanc\OneDrive - Aegis Biz Tech LLC\Documents\WindowsPowerShell\FHA DL.csv'

foreach ($Contact in $Contacts)
{

    Remove-DistributionGroupMember -Identity 'MemberHospitalCMOs' -Member $Contact.emailaddress -Confirm:$false

}

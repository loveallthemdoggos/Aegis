Connect-ExchangeOnline

$Contacts = Import-Csv 'C:\Users\ackermanc\OneDrive - Aegis Biz Tech LLC\Documents\WindowsPowerShell\FHA DL.csv'


foreach ($contact in $contacts){

    $name          = $contact.DisplayName
    $externalemail = $contact.Email
    New-MailContact -Name $name -ExternalEmailAddress $externalemail


}

New-DistributionGroup -DisplayName "Emergency Updates" -PrimarySmtpAddress emergencyupdates@thesoutherngroup.com

foreach ($contact in $contacts){

    $name          = $contact.DisplayName
    $externalemail = $contact.Email
    Add-DistributionGroupMember -Identity "Emergency Updates" -Member $externalemail


}

Get-DistributionGroupMember "Emergency Updates"

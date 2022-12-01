Get-DistributionGroupMember -Identity "HospitalCEOs" | fl displayname, emailaddresses > FHACEO.csv

Get-DistributionGroupMember -Identity "MemberHospitalCEOs" | fl displayname, emailaddresses > FHAMemberCEO.csv
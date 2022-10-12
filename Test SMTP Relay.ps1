#Test SMTP relay for a scanner after setting up in mail assure and entering settings on scanner

Send-MailMessage -from (scans@domainname.com) -To xxxxxxxxx@aegisbiztech.com -Subject test -Body test -SmtpServer smtpout-us.mtaroutes.com -Port 587 -UseSsl




# Import the required module
Import-Module ActiveDirectory

<#
Run change password script only when internet is working
#>
IF (Test-NetConnection smtp.gmail.com -InformationLevel Quiet) {
	<#
	Create new random password
	#>

	# Get the current username
	# use command 'net user' to get a list of users
	$username = "xxxxx"

	#create a random 16 digit secure password
	$Passwd = -join ((48..122) | Get-Random -Count 16 | ForEach-Object{[char]$_})

	# update password
	$updated = net user $username $Passwd

	if ($updated) {
    	Write-Host "PIN changed successfully."
		<#
		Send updated password/pin to email address
		#>
		# Email to send with
		$userName = 'sender@xyz.com'
		# Email to send to
		$To = 'receiver@xyz.com'
		# SMTP credentials
		$smtpKey = 'KEY-HERE'
		$currentTime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
		[SecureString]$securepassword = $smtpKey | ConvertTo-SecureString -AsPlainText -Force
		$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $securepassword
		$subject = 'New login to $username'
		$body = "There has been a new login to account $username at $currentTime (GMT+5). Your current password has been updated to $Passwd."
		Send-MailMessage -SmtpServer smtp.gmail.com -Port 587 -UseSsl -From $userName -To $To -Subject $subject -Body $body -Credential $credential
	} else {
    		Write-Host "Error updating password."
	}

} ELSE {
	write-host "Not connected to the internet"
}



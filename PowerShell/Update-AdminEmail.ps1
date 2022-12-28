 <#
Get Admin Users who are Disabled AND don't
have an email address assigned in
extensionAttribute10
#>
$adusers = Get-ADUser -Filter {Enabled -eq "True" -AND extensionAttribute10 -notlike "*"} -SearchBase "OU=administrator,DC=docusignhq,DC=com"

<#
For each user who doesn't have an email
addressed assigned in extensionAttribute10,
we'll construct the email address for them
using their Full Name.

We'll split the Full Name into an array so 
we can pick and choose which words we want 
to use to format the email address.

And output the email address for each user.
#>
try
{
  foreach ($aduser in $adusers)
  {
    $aduser_name_split = @($aduser.Name.Split())
    $email_constructed = ($aduser_name_split[-2]) + '.' + ($aduser_name_split[-1]) + '@docusign.com'
    Write-Output "$aduser_name_split will have the email address: $email_constructed"
  }
}
catch
{
  Write-Output "Couldn't construct the email address. Please check the user's Full Name to see where there might be an error."
}


<#
Prompt the user to confirm adding the email address for each user
#>
$confirmation = Read-Host "Do you want to proceed? Y or N"
if ($confirmation -eq 'y')
{
  foreach ($aduser in $adusers)
  {
    $aduser_name_split = @($aduser.Name.Split())
    $email_constructed = ($aduser_name_split[-2]) + '.' + ($aduser_name_split[-1]) + '@docusign.com'
    Set-AdUser -Identity $aduser -Add @{"extensionAttribute10"=$email_constructed}
    Write-Output "Adding email address $email_constructed for user $aduser_name_split"
  }
}
else
{
  Write-Output "Cancelling..."
}
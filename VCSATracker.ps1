param (
    [string]$vcentre,
    [string]$username,
    [string]$password,
    [string]$VMName
)
.'C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1' | out-null
Start-Sleep -s 5
Connect-VIServer -Server $vcentre -User $username -Password "$password"
$details = get-vm $VMName | select Name, VMHost

$XML = "<prtg>"
foreach($detail in $details){
    $Name = $detail.Name
    $VMHost = $detail.VMHost
    $VMHostnum = $VMHost -replace '\D+'
	
    $XML += "<result>"
    $XML += "<channel>ESX Host</channel>"
    $XML += "<value>$VMHostnum</value>"
    $XML += "<unit>custom</unit>"
    $XML += "</result>"
    $XML += "<text>$VMHost</text>"
    
    $result = $null
}
$XML += "</prtg>"

Function WriteXmlToScreen ([xml]$xml)
{
    $StringWriter = New-Object System.IO.StringWriter;
    $XmlWriter = New-Object System.Xml.XmlTextWriter $StringWriter;
    $XmlWriter.Formatting = "indented";
    $xml.WriteTo($XmlWriter);
    $XmlWriter.Flush();
    $StringWriter.Flush();
    Write-Output $StringWriter.ToString();
}

WriteXmlToScreen $XML

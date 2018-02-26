# Power Shell

## Power Shell Remoting

### Enter Secure Credential

#### Create SecureString

Type the password in an interactive prompt

```ps
$passwd = Read-Host -Prompt "Enter password" -AsSecureString
```

#### Convert from existing plaintext variable
```ps
$passwd = "" | ConvertTo-SecureString -AsPlainText -Force
```

#### Create PSCredentials
Assuming that you have password in SecureString form in $passwd variable:
```ps
$cred = New-Object System.Management.Automation.PSCredential `
     -ArgumentList "", $passwd
```


### Configure WinRM HTTPS

#### Create self signed cert
```ps
$newDns = ""

$Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName $newDns

Export-Certificate -Cert $Cert -FilePath $HOME\Documents\winrm-https-cert.cer
Import-Certificate -Filepath $HOME\Documents\winrm-https-cert.cer -CertStoreLocation "Cert:\LocalMachine\Root"
```

#### Create HTTPS Listener
```ps
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint –Force
```

#### Add Firewall Rule for WinRM HTTPS
```ps
New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any -LocalPort 5986 -Protocol TCP
```

### Remove WinRM Config
```ps
REM For an HTTP Listener:
winrm delete winrm/config/Listener?Address=*+Transport=HTTP

REM For an HTTPS Listener:
winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
```

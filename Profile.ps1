# Signing How-to:
# 1. Generate certificate
# $cert = New-SelfSignedCertificate -DnsName "YourCertName" -CertStoreLocation "cert:\CurrentUser\My"
# 2. Export certificate
# Export-PfxCertificate -Cert $cert -FilePath "C:\path\to\your\certificate.pfx" -Password (ConvertTo-SecureString -String "YourPassword" -Force -AsPlainText)
# 3. Install certificate
# Import-PfxCertificate -FilePath "C:\path\to\your\certificate.pfx" -CertStoreLocation Cert:\CurrentUser\Root -Password (ConvertTo-SecureString -String "YourPassword" -Force -AsPlainText)
# 4. Initially, and whenever code is modified, re-sign with:
# Set-AuthenticodeSignature -FilePath "$HOME\Documents\PowerShell\Profile.ps1" (Get-ChildItem Cert:\CurrentUser\My\<your-certificate-ID>)


# Functions for Git-aware prompt

function Get-GitBranchPrompt
{
  if ((Test-Path .git) -or (Test-Path ..\.git) -or (Test-Path ..\..\.git) -or (Test-Path ..\..\..\.git) -or (Test-Path ..\..\..\..\.git) -or (Test-Path ..\..\..\..\..\.git) -or (Test-Path ..\..\..\..\..\..\.git) -or (Test-Path ..\..\..\..\..\..\..\.git)) {
    #$branch = git rev-parse --abbrev-ref HEAD
    $branch = git branch --show-current
    return $branch
  }
  return ""
}

function prompt
{
  $d = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $p = Get-Location
  $b = Get-GitBranchPrompt
  Write-Host ""
  Write-Host -NoNewline "$p"
  if ($b -ne "") {
    Write-Host -NoNewline -ForegroundColor Yellow " ($b)"
  }
  Write-Host -ForegroundColor DarkCyan " [$d]"
  Write-Host -NoNewLine ">"
  return " "
}

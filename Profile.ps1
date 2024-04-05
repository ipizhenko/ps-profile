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

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
  $p = Get-Location
  $b = Get-GitBranchPrompt
  Write-Host ""
  Write-Host -NoNewline "$p"
  if ($b -ne "") {
    Write-Host -ForegroundColor Yellow " ($b)"
  }
  Write-Host -NoNewLine ">"
  return " "
}

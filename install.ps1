# dont-slop-me zero-dependency installer for Windows PowerShell
# Supports: -Global (default), -Project, and -Uninstall

[CmdletBinding()]
param(
    [switch]$Global,
    [switch]$Project,
    [switch]$Uninstall,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

if ($Help) {
    Write-Host "dont-slop-me installer"
    Write-Host "Usage: .\install.ps1 [-Global | -Project | -Uninstall]"
    Write-Host "  -Global    Install to user skills and detected IDE configurations (default)"
    Write-Host "  -Project   Install into current working directory"
    Write-Host "  -Uninstall Remove installed dont-slop-me skills"
    exit 0
}

$RepoOwner = "zchuwie"
$RepoName = "dont-slop-me"
$RepoBranch = "main"
$RawBase = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$RepoBranch"

$Mode = "Global"
if ($Project) {
    $Mode = "Project"
}

$ScriptDir = ""
if ($PSScriptRoot) {
    $ScriptDir = $PSScriptRoot
}

$LocalSource = ""
if ($ScriptDir -and (Test-Path (Join-Path $ScriptDir "skills\dont-slop-me"))) {
    $LocalSource = $ScriptDir
}

function Get-GlobalDestinations {
    $dests = [System.Collections.Generic.List[string]]::new()
    $homeDir = $HOME

    $dests.Add((Join-Path $homeDir ".agents\skills"))

    if (Test-Path (Join-Path $homeDir ".cursor")) {
        $dests.Add((Join-Path $homeDir ".cursor\rules"))
    }
    if (Test-Path (Join-Path $homeDir ".continue")) {
        $dests.Add((Join-Path $homeDir ".continue\prompts"))
    }
    if (Test-Path (Join-Path $homeDir ".codeium\windsurf")) {
        $dests.Add((Join-Path $homeDir ".codeium\windsurf\memories"))
    }
    if (Test-Path (Join-Path $homeDir ".claude")) {
        $dests.Add((Join-Path $homeDir ".claude\skills"))
    }
    if (Test-Path (Join-Path $homeDir ".gemini")) {
        $dests.Add((Join-Path $homeDir ".gemini\skills"))
    }
    if (Test-Path (Join-Path $homeDir ".codex")) {
        $dests.Add((Join-Path $homeDir ".codex\skills"))
    }

    return $dests
}

function Get-ProjectDestinations {
    $dests = [System.Collections.Generic.List[string]]::new()
    $pwd = Get-Location

    $dests.Add((Join-Path $pwd ".agents\skills"))

    if (Test-Path (Join-Path $pwd ".cursor")) {
        $dests.Add((Join-Path $pwd ".cursor\rules"))
    }
    if (Test-Path (Join-Path $pwd ".continue")) {
        $dests.Add((Join-Path $pwd ".continue\prompts"))
    }
    if (Test-Path (Join-Path $pwd ".claude")) {
        $dests.Add((Join-Path $pwd ".claude\skills"))
    }

    return $dests
}

$SkillFiles = @(
    "skills/dont-slop-me/SKILL.md",
    "skills/dont-slop-me/references/codebase-discovery.md",
    "skills/dont-slop-me/references/copy-and-code-hygiene.md",
    "skills/dont-slop-me-ui/SKILL.md",
    "skills/dont-slop-me-ui/references/anti-slop-checklist.md",
    "skills/dont-slop-me-ui/references/ux-and-motion-spec.md"
)

function Install-SkillFiles {
    param([string]$TargetRoot)

    Write-Host "Installing dont-slop-me to: $TargetRoot" -ForegroundColor Cyan

    foreach ($relPath in $SkillFiles) {
        $stripped = $relPath.Substring("skills/".Length)
        $destFile = Join-Path $TargetRoot ($stripped.Replace("/", [System.IO.Path]::DirectorySeparatorChar))
        $destDir = Split-Path $destFile -Parent

        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        if ($LocalSource -and (Test-Path (Join-Path $LocalSource ($relPath.Replace("/", [System.IO.Path]::DirectorySeparatorChar))))) {
            Copy-Item (Join-Path $LocalSource ($relPath.Replace("/", [System.IO.Path]::DirectorySeparatorChar))) $destFile -Force
        }
        else {
            $url = "$RawBase/$relPath"
            Invoke-RestMethod -Uri $url -OutFile $destFile
        }
    }
}

function Uninstall-SkillFiles {
    param([string]$TargetRoot)

    Write-Host "Uninstalling dont-slop-me from: $TargetRoot" -ForegroundColor Yellow
    $p1 = Join-Path $TargetRoot "dont-slop-me"
    $p2 = Join-Path $TargetRoot "dont-slop-me-ui"

    if (Test-Path $p1) { Remove-Item -Recurse -Force $p1 }
    if (Test-Path $p2) { Remove-Item -Recurse -Force $p2 }
}

$targetDests = if ($Mode -eq "Global") { Get-GlobalDestinations } else { Get-ProjectDestinations }

if ($Uninstall) {
    foreach ($d in $targetDests) {
        if (Test-Path $d) {
            Uninstall-SkillFiles -TargetRoot $d
        }
    }
    Write-Host "dont-slop-me uninstalled successfully." -ForegroundColor Green
    exit 0
}

foreach ($d in $targetDests) {
    Install-SkillFiles -TargetRoot $d
}

Write-Host ""
Write-Host "dont-slop-me installed successfully in $Mode mode." -ForegroundColor Green
Write-Host "Active skills: dont-slop-me, dont-slop-me-ui" -ForegroundColor Green


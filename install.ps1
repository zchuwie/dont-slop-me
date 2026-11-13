# dontslopme zero-dependency installer for Windows PowerShell
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
    Write-Host "dontslopme installer"
    Write-Host "Usage: .\install.ps1 [-Global | -Project | -Uninstall]"
    Write-Host "  -Global    Install to user skills and detected IDE configurations (default)"
    Write-Host "  -Project   Install into current working directory"
    Write-Host "  -Uninstall Remove installed dontslopme skills"
    exit 0
}

$RepoOwner = "zchuwie"
$RepoName = "dontslopme"
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
if ($ScriptDir -and (Test-Path (Join-Path $ScriptDir "skills\dontslopme"))) {
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
    "skills/dontslopme/SKILL.md",
    "skills/dontslopme/references/codebase-discovery.md",
    "skills/dontslopme/references/copy-and-code-hygiene.md",
    "skills/dontslopme-ui/SKILL.md",
    "skills/dontslopme-ui/references/anti-slop-checklist.md",
    "skills/dontslopme-ui/references/ux-and-motion-spec.md"
)

function Install-SkillFiles {
    param([string]$TargetRoot)

    Write-Host "Installing dontslopme to: $TargetRoot" -ForegroundColor Cyan

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

    Write-Host "Uninstalling dontslopme from: $TargetRoot" -ForegroundColor Yellow
    $p1 = Join-Path $TargetRoot "dontslopme"
    $p2 = Join-Path $TargetRoot "dontslopme-ui"

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
    Write-Host "dontslopme uninstalled successfully." -ForegroundColor Green
    exit 0
}

foreach ($d in $targetDests) {
    Install-SkillFiles -TargetRoot $d
}

Write-Host ""
Write-Host "dontslopme installed successfully in $Mode mode." -ForegroundColor Green
Write-Host "Active skills: dontslopme, dontslopme-ui" -ForegroundColor Green


param(
    [Parameter(Position = 0)]
    [ValidateSet("codex", "claude", "both")]
    [string]$Target = "both",
    [switch]$Verify
)

# Installs Skills only. Hook examples, including the OpenCode plugin example,
# are bundled under using-harness/hooks/ and are copied with the Skills.
$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

$FormalSkills = @(
    "using-harness",
    "harness-start-gate",
    "harness-delegation-gate",
    "harness-knowledge-retrieval",
    "harness-spec-drift",
    "harness-doc-lifecycle",
    "harness-incident-learning",
    "harness-vision-gate",
    "harness-readiness-dashboard",
    "harness-change-narrative",
    "harness-knowledge-capture",
    "harness-project-rules"
)

$RequiredBundledResources = @(
    "using-harness\scripts\knowledge_check.py",
    "using-harness\scripts\harness_closeout_check.py",
    "using-harness\scripts\hook_diagnostics.py",
    "using-harness\scripts\skill_metadata_check.py",
    "using-harness\scripts\usage_record.py",
    "using-harness\hooks\harness_hook.py",
    "using-harness\assets\templates\AGENTS.md"
)

function Get-HarnessDestination {
    param([ValidateSet("codex", "claude")] [string]$Name)

    if ($Name -eq "codex" -and $env:HARNESS_CODEX_SKILLS_DIR) {
        return $env:HARNESS_CODEX_SKILLS_DIR
    }
    if ($Name -eq "claude" -and $env:HARNESS_CLAUDE_SKILLS_DIR) {
        return $env:HARNESS_CLAUDE_SKILLS_DIR
    }
    if ($Name -eq "codex") {
        return (Join-Path $HOME ".codex\skills")
    }
    return (Join-Path $HOME ".claude\skills")
}

function Test-HarnessInstall {
    param(
        [string]$Destination,
        [string]$Label
    )

    $Errors = New-Object System.Collections.Generic.List[string]
    if (-not (Test-Path $Destination)) {
        $Errors.Add("destination does not exist: $Destination")
    }

    foreach ($Skill in $FormalSkills) {
        $SkillFile = Join-Path $Destination (Join-Path $Skill "SKILL.md")
        if (-not (Test-Path $SkillFile)) {
            $Errors.Add("missing $Skill/SKILL.md in $Destination")
        }
    }

    foreach ($Resource in $RequiredBundledResources) {
        $Path = Join-Path $Destination $Resource
        if (-not (Test-Path $Path)) {
            $Errors.Add("missing bundled resource: $Path")
        }
    }

    if ($Errors.Count -gt 0) {
        foreach ($Message in $Errors) {
            [Console]::Error.WriteLine("Verification error: $Message")
        }
        throw "Verification: failed for $Label with $($Errors.Count) error(s)."
    }

    Write-Host "Verification: passed for $Label at $Destination"
}

function Install-HarnessSkills {
    param(
        [string]$Destination,
        [string]$Label
    )

    New-Item -ItemType Directory -Force $Destination | Out-Null
    Copy-Item (Join-Path $RepoRoot "skills\*") $Destination -Recurse -Force
    Write-Host "Installed Harness skills to $Destination"
    Test-HarnessInstall $Destination $Label
}

function Invoke-HarnessVerify {
    param(
        [string]$Destination,
        [string]$Label
    )

    Write-Host "Verify-only: no files were copied for $Label."
    Test-HarnessInstall $Destination $Label
}

function Write-HarnessNextSteps {
    Write-Host "Restart your agent so it can reload Skill metadata."
    Write-Host "Use ``using-harness`` as the entrypoint after restart."
    Write-Host "Hooks are optional. To check Codex Stop hook runtime after hook setup, run:"
    Write-Host "  python <skills-root>/using-harness/scripts/hook_diagnostics.py codex --project-root <project>"
}

switch ($Target) {
    "codex" {
        $Destination = Get-HarnessDestination "codex"
        if ($Verify) {
            Invoke-HarnessVerify $Destination "Codex"
        } else {
            Install-HarnessSkills $Destination "Codex"
        }
    }
    "claude" {
        $Destination = Get-HarnessDestination "claude"
        if ($Verify) {
            Invoke-HarnessVerify $Destination "Claude Code"
        } else {
            Install-HarnessSkills $Destination "Claude Code"
        }
    }
    "both" {
        $CodexDestination = Get-HarnessDestination "codex"
        $ClaudeDestination = Get-HarnessDestination "claude"
        if ($Verify) {
            Invoke-HarnessVerify $CodexDestination "Codex"
            Invoke-HarnessVerify $ClaudeDestination "Claude Code"
        } else {
            Install-HarnessSkills $CodexDestination "Codex"
            Install-HarnessSkills $ClaudeDestination "Claude Code"
        }
    }
}

Write-HarnessNextSteps

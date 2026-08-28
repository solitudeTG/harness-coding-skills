param(
    [Parameter(Position = 0)]
    [ValidateSet("codex", "claude", "both")]
    [string]$Target = "both",
    [switch]$Verify
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$FormalSkills = @("harness", "harness-intent", "harness-decision", "harness-learning", "harness-evidence", "harness-closeout")
$LegacySkills = @("using-harness", "harness-start-gate", "harness-delegation-gate", "harness-knowledge-retrieval", "harness-spec-drift", "harness-doc-lifecycle", "harness-incident-learning", "harness-vision-gate", "harness-readiness-dashboard", "harness-change-narrative", "harness-knowledge-capture", "harness-project-rules")
$RequiredResources = @("harness\scripts\generate_index.py", "harness\scripts\knowledge_check.py", "harness\assets\templates\FEATURE.md", "harness\assets\templates\ADR.md", "harness\assets\templates\LESSON.md", "harness\assets\templates\EVIDENCE.md", "harness\assets\templates\CLOSEOUT_COMPACT.md")

function Get-Destination([string]$Name) {
    if ($Name -eq "codex") { return $(if ($env:HARNESS_CODEX_SKILLS_DIR) { $env:HARNESS_CODEX_SKILLS_DIR } else { Join-Path $HOME ".codex\skills" }) }
    return $(if ($env:HARNESS_CLAUDE_SKILLS_DIR) { $env:HARNESS_CLAUDE_SKILLS_DIR } else { Join-Path $HOME ".claude\skills" })
}

function Test-Install([string]$Destination, [string]$Label) {
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($skill in $FormalSkills) { if (-not (Test-Path (Join-Path $Destination "$skill\SKILL.md"))) { $errors.Add("missing $skill/SKILL.md") } }
    foreach ($skill in $LegacySkills) { if (Test-Path (Join-Path $Destination $skill)) { $errors.Add("legacy Skill still exists: $skill") } }
    foreach ($resource in $RequiredResources) { if (-not (Test-Path (Join-Path $Destination $resource))) { $errors.Add("missing resource: $resource") } }
    if ($errors.Count) { $errors | ForEach-Object { [Console]::Error.WriteLine("Verification error: $_") }; throw "Verification failed for $Label." }
    Write-Host "Verification: passed for $Label at $Destination"
}

function Install([string]$Destination, [string]$Label) {
    New-Item -ItemType Directory -Force $Destination | Out-Null
    foreach ($skill in $LegacySkills) { $target = Join-Path $Destination $skill; if (Test-Path $target) { Remove-Item -LiteralPath $target -Recurse -Force } }
    Copy-Item (Join-Path $RepoRoot "skills\*") $Destination -Recurse -Force
    Test-Install $Destination $Label
}

foreach ($name in $(if ($Target -eq "both") { @("codex", "claude") } else { @($Target) })) {
    $destination = Get-Destination $name
    if ($Verify) { Test-Install $destination $name } else { Install $destination $name }
}
Write-Host "Restart the agent to reload Harness vNext metadata. Use 'harness' to read the engineering Index when task context matters; event Skills trigger only when their event occurs."

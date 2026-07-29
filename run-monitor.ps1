# tiny-cap-monitor: headless run, triggered by Windows Task Scheduler.
# Local automation only (no hosted cloud cron) - uses the normal Claude Code CLI/plan.
$claude = "C:\Users\CH\.local\bin\claude.exe"
$logDir = "C:\Users\CH\ClaudeData\tiny-cap-monitor"
$stamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$runLog = Join-Path $logDir "runs.log"

"---- Run start $stamp ----" | Out-File -FilePath $runLog -Append -Encoding utf8

Push-Location $logDir
& $claude -p "/tiny-cap-monitor" `
    --allowedTools "WebFetch,Bash,Read,Write,Edit" `
    --permission-mode acceptEdits `
    --max-budget-usd 0.20 `
    --output-format text `
    --no-session-persistence *>> $runLog
Pop-Location

"---- Run end $(Get-Date -Format 'yyyy-MM-dd_HHmm') ----" | Out-File -FilePath $runLog -Append -Encoding utf8

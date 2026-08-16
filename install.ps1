# 手动安装备用脚本（推荐用：dsh plugin --profile web add github:sailoumili/novel-writer）
# ============================================================
# 多核协同写作模式 —— 一键安装脚本（Windows）
# 用于 DeepSeek Harness（DSH）
# 装完后：刷新或重启 DSH 页面，新建会话时选「多核协同写作模式」
# ============================================================

$ErrorActionPreference = "Stop"

# GitHub 仓库 raw 地址（sailoumili 为本仓库用户名）
$repo = "https://raw.githubusercontent.com/sailoumili/novel-writer/main"

# 预设 id（文件夹名，固定小写英文，不能改中文）
$presetId = "novel-writer"

# 目标目录：~/.dsh/.agent-presets/novel-writer
$target = Join-Path $env:USERPROFILE (".dsh\.agent-presets\" + $presetId)

Write-Host "正在安装「多核协同写作模式」..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $target | Out-Null

foreach ($f in @("agent.cordis.yml", "preset.yml")) {
    Write-Host "  下载 $f ..."
    Invoke-RestMethod -Uri "$repo/$f" -OutFile (Join-Path $target $f)
}

Write-Host ""
Write-Host "✅ 安装完成！" -ForegroundColor Green
Write-Host "   预设位置：$target"
Write-Host "   下一步：刷新或重启 DSH 页面，新建会话时选「多核协同写作模式」。"

#!/usr/bin/env bash
# Fallback manual installer (prefer: dsh plugin --profile web add github:sailoumili/novel-writer)
# ============================================================
# 多核协同写作模式 —— 一键安装脚本（macOS / Linux）
# 用于 DeepSeek Harness（DSH）
# ============================================================
set -euo pipefail

REPO="https://raw.githubusercontent.com/sailoumili/novel-writer/main"
PRESET_ID="novel-writer"
TARGET="${HOME}/.dsh/.agent-presets/${PRESET_ID}"

echo "正在安装「多核协同写作模式」..."
mkdir -p "$TARGET"

for f in agent.cordis.yml preset.yml; do
  echo "  下载 $f ..."
  curl -fsSL "$REPO/$f" -o "$TARGET/$f"
done

echo ""
echo "✅ 安装完成！"
echo "   预设位置：$TARGET"
echo "   下一步：刷新或重启 DSH 页面，新建会话时选「多核协同写作模式」。"

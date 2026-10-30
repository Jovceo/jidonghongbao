#!/bin/bash
# 整点抢红包桌面提醒（macOS / Linux）——只提醒，不自动操作浏览器、不绕过领取授权。
# 用法：remind.sh am   （09:53 触发，提示 10:00 场次）
#       remind.sh pm   （19:53 触发，提示 20:00 场次）
# 注册：见 references/macos-browser.md「提醒定时」cron 示例。
# 活动期 2026.10.12-11.11，之后删除 crontab 条目即可。
SESSION="${1:-am}"
if [ "$SESSION" = "pm" ]; then
  TITLE="20:00 京东晚场加码"; MIN="7"
else
  TITLE="10:00 京东整点加码"; MIN="7"
fi
MSG="$TITLE，还有约 $MIN 分钟。打开你的 AI 工具，说一句：开抢"
if command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"$MSG\" with title \"双11 抢红包提醒\""
elif command -v notify-send >/dev/null 2>&1; then
  notify-send "双11 抢红包提醒" "$MSG"
else
  echo "提醒: $MSG"
fi

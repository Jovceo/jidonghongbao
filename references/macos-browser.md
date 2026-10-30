# macOS 浏览器接入（理论兼容，未经实机验证）

> **诚实口径**：截至 2026-10-30，本技能所有实战记录均产生于 Windows 宿主。本文件的 macOS 指引基于工具的跨平台公开文档编写，**未实机跑通**。首次按本文件执行时，先走「只看不点」验收，任何一步与描述不符即停下如实报告，不得声称验证通过。

## 平台无关的部分（可直接复用）

SKILL.md 的全部战术（踩点刷新、弹层判据、选择器、二分法、场次纪律）作用在网页 DOM 上，与操作系统无关。活动页是同一个 URL，浏览器工具相同则页面行为相同。

## 浏览器工具接入

| 方式 | macOS 命令/说明 | 备注 |
|---|---|---|
| Playwright MCP | `npx -y @playwright/mcp@0.0.83`（写入宿主 MCP 配置，参考 `examples/windows-edge-profile.mcp.json` 的 args 结构，把 Windows 路径换成 macOS 的 `--user-data-dir` 目录，如 `~/Library/Application Support/Google/Chrome/Profile Debug`） | Chrome/Chromium 官方支持 macOS |
| Chrome 扩展模式 | 同 Windows：安装 Playwright 浏览器扩展后在扩展页批准连接 | 扩展行为跨平台一致 |
| 宿主自带浏览器工具（如 Qoder browser-use） | 无需额外配置，直接复用 | 满足「打开页面/读 DOM/点击」三能力即可 |

## 技能安装路径（用户级）

| 宿主 | macOS 路径 |
|---|---|
| Qoder | `~/.qoder/skills/jidonghongbao/SKILL.md` |
| Claude Code | `~/.claude/skills/jidonghongbao/SKILL.md` |
| WorkBuddy | 按宿主文档（Windows 路径为 `%USERPROFILE%\.workbuddy-ai\skills\`，macOS 对应目录未实测，查宿主设置） |

## 整点等待命令（替代 PowerShell）

```bash
# 踩点导航：睡到 09:59:57（晚场改 19:59:57）
NOW=$(date +%s); TARGET=$(( ($(date -j -f "%H:%M:%S" "09:59:57" +%s) ) )); [ $NOW -lt $TARGET ] && sleep $((TARGET-NOW)); date "+NAVIGATE at %H:%M:%S"
```

## 提醒定时（替代 Windows 计划任务）

```bash
# cron 每日 09:53 桌面通知（scripts/remind.sh）
crontab -l 2>/dev/null | grep -v remind.sh; { crontab -l 2>/dev/null; echo "53 9 * * * $(pwd)/scripts/remind.sh"; } | crontab -
```

> cron 需系统处于唤醒状态；Mac 休眠时不触发，重要场次以人工提醒为准。

## 首次实机必须验证的清单（验证通过后更新本文件与 README 兼容表）

1. 推广短链重定向后 `unionActId` 参数保留
2. 活动页 TARO 渲染正常（taro 节点数 ≈ 172）
3. 登录判据文案一致（「你好，请登录」）
4. 整点前 1-2 秒踩点导航能出游戏/加码弹层
5. 合成点击与真实点击在败局层的行为是否同 Windows

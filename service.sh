#!/system/bin/sh
# 获取当前模组所在的目录路径
MODDIR=${0%/*}

# 1. 等待系統啟動完成
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 3
done

# 2. 開機後延遲 30 秒
sleep 30

# 3. 替换为 Bitwarden 的完整服务路径
TARGET="com.x8bit.bitwarden/com.x8bit.bitwarden.autofill.AutofillService"

# 4. 日志存储位置
LOG="/data/local/tmp/autofill_fix.log"

echo "$(date): Bitwarden Autofill watchdog started" >> "$LOG"

# 5. 将死循环丢入后台异步执行 (注意末尾的 &)，避免阻塞 Root 管理器
(
    while true
    do
        # 【关键防护】：如果检测到用户禁用了模组或标记了删除，立即终止脚本
        if [ -f "$MODDIR/disable" ] || [ -f "$MODDIR/remove" ]; then
            echo "$(date): Module disabled or removed. Stopping watchdog." >> "$LOG"
            exit 0
        fi

        CURRENT=$(settings get secure autofill_service)

        if [ "$CURRENT" != "$TARGET" ]; then
            echo "$(date): Change $CURRENT -> $TARGET" >> "$LOG"
            settings put secure autofill_service "$TARGET"
        fi

        # 每 5 分钟检查一次
        sleep 300
    done
) &

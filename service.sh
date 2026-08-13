#!/system/bin/sh

# 1. 等待系統啟動完成
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 3
done

# 2. 開機後延遲 30 秒
sleep 30

# 3. 替換為 Bitwarden 的完整服務路徑
TARGET="com.x8bit.bitwarden/com.x8bit.bitwarden.autofill.AutofillService"

# 4. 日誌儲存位置
LOG="/data/local/tmp/autofill_fix.log"

echo "$(date): Bitwarden Autofill watchdog started" >> "$LOG"

# 5. 輪詢防護循環
while true
do
    CURRENT=$(settings get secure autofill_service)

    if [ "$CURRENT" != "$TARGET" ]; then
        echo "$(date): Change $CURRENT -> $TARGET" >> "$LOG"
        settings put secure autofill_service "$TARGET"
    fi

    sleep 300
done

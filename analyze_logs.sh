#!/bin/bash
LOG_FILE="access.log"
# Генерация тестового лога, если его нет
if [ ! -f "$LOG_FILE" ]; then
    for i in {1..300}; do
        IP="192.168.1.$((RANDOM % 255 + 1))"
        CODE=$((RANDOM % 5 == 0 ? (RANDOM % 2 == 0 ? 404 : 500) : 200))
        echo "$IP - - [15/Aug/2026:10:15:32] \"GET /api/test HTTP/1.1\" $CODE" >> "$LOG_FILE"
    done
fi

echo "Общее количество запросов:"
wc -l < "$LOG_FILE"
echo -e "\nТоп-3 IP-адреса:"
# Используем регулярное выражение для извлечения IP-адресов
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -3
echo -e "\nКоличество запросов с кодами 4xx и 5xx:"
grep -cE ' (4[0-9]{2}|5[0-9]{2}) ' "$LOG_FILE"
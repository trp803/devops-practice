#!/bin/bash

# ================================
# Health Check скрипт
# ================================

ERRORS=0

check() {
    if [ $? -eq 0 ]; then
        echo "✅ $1"
    else
        echo "❌ $1"
        ERRORS=$((ERRORS + 1))
    fi
}

echo "=== Health Check $(date) ==="
echo ""

# Проверка диска (меньше 80% занято?)
DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
[ "$DISK" -lt 80 ]
check "Диск: ${DISK}% занято"

# Проверка памяти
FREE_MEM=$(free | awk 'NR==2 {print $4}')
[ "$FREE_MEM" -gt 100000 ]
check "Память: свободно $(free -h | awk 'NR==2 {print $4}')"

# Проверка Docker
systemctl is-active docker > /dev/null 2>&1
check "Docker запущен"

# Проверка интернета
ping -c 1 8.8.8.8 > /dev/null 2>&1
check "Интернет доступен"

echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "🟢 Сервер в норме"
else
    echo "🔴 Найдено проблем: $ERRORS"
fi

#!/bin/bash

echo "================================"
echo "   ИНФОРМАЦИЯ О СЕРВЕРЕ"
echo "================================"

echo ""
echo "📅 Дата и время: $(date)"
echo "🖥️  Hostname: $(hostname)"
echo "🐧 OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2)"

echo ""
echo "💾 ПАМЯТЬ:"
free -h

echo ""
echo "💿 ДИСК:"
df -h /

echo ""
echo "⚡ НАГРУЗКА:"
uptime

echo ""
echo "🐳 DOCKER контейнеры:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "================================"

#!/bin/bash

# ================================
# Универсальный скрипт деплоя
# ================================

CONTAINER_NAME=$1
PORT=$2
IMAGE_NAME=$3
PROJECT_DIR=$4

log() {
    echo "[$(date +%H:%M:%S)] $1"
}

# Проверка аргументов
if [ -z "$CONTAINER_NAME" ] || [ -z "$PORT" ] || [ -z "$IMAGE_NAME" ] || [ -z "$PROJECT_DIR" ]; then
    echo "Использование: ./deploy.sh <имя_контейнера> <порт> <имя_образа> <папка_проекта>"
    exit 1
fi

log "🚀 Начинаю деплой $CONTAINER_NAME на порту $PORT"

# Останови и удали старый контейнер если есть
if docker ps -a | grep -q "$CONTAINER_NAME"; then
    log "Останавливаю старый контейнер $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    log "✅ Старый контейнер удалён"
fi

# Проверь занят ли порт
if docker ps | grep -q "0.0.0.0:$PORT"; then
    log "⚠️ Порт $PORT занят! Освобождаю..."
    CONTAINER=$(docker ps | grep "0.0.0.0:$PORT" | awk '{print $NF}')
    docker stop $CONTAINER
    docker rm $CONTAINER
    log "✅ Порт $PORT освобождён"
fi

# Собери новый образ
log "Собираю образ $IMAGE_NAME..."
cd $PROJECT_DIR
docker build -t $IMAGE_NAME .

# Запусти новый контейнер
log "Запускаю контейнер $CONTAINER_NAME..."
docker run -d \
    -p $PORT:80 \
    --name $CONTAINER_NAME \
    --restart always \
    $IMAGE_NAME

# Проверь что запустился
if docker ps | grep -q "$CONTAINER_NAME"; then
    log "✅ $CONTAINER_NAME успешно запущен на порту $PORT"
else
    log "❌ Ошибка запуска $CONTAINER_NAME"
    exit 1
fi

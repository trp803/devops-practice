# Изменён: 2026-03-24 — добавлен не-root пользователь в продакшн образ (безопасность)

# Этап 1 — сборка (builder)
# На этапе сборки пользователь не важен — образ не запускается в продакшне
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Этап 2 — продакшн образ
FROM node:18-alpine

# Создаём группу и пользователя nodeuser (uid=1001, gid=1001)
# Фиксированные uid/gid — лучшая практика: поведение одинаково на любом хосте
RUN addgroup -g 1001 nodegroup && \
    adduser -u 1001 -G nodegroup -s /bin/sh -D nodeuser

WORKDIR /app

# Копируем файлы из builder и сразу передаём владение пользователю nodeuser
COPY --from=builder --chown=nodeuser:nodegroup /app .

# Переключаемся на не-root пользователя
USER nodeuser

EXPOSE 3000
CMD ["node", "app.js"]

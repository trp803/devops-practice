# Изменён: 2026-03-24 — добавлен не-root пользователь (безопасность)
FROM ubuntu:22.04

RUN apt update && apt install -y curl

# Создаём системного пользователя appuser без пароля и домашней директории
# Запуск от root внутри контейнера опасен: если взломают приложение,
# атакующий получит root-доступ к хосту через уязвимости Docker
RUN useradd --system --no-create-home appuser

WORKDIR /app

COPY . .

# Передаём владение папкой /app новому пользователю
RUN chown -R appuser:appuser /app

# Переключаемся на не-root пользователя — все следующие команды выполняются от него
USER appuser

CMD ["echo", "Hello from my first Docker image!"]

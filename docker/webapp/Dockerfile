# Изменён: 2026-03-24 — добавлен не-root пользователь (безопасность)
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

# Даём пользователю nginx право на нужные директории.
# Образ nginx:alpine уже содержит встроенного пользователя nginx (uid=101),
# поэтому создавать нового не нужно — просто передаём ему владение файлами
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

# Переключаемся на пользователя nginx
USER nginx

EXPOSE 80

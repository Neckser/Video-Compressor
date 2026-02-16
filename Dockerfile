FROM ubuntu:22.04

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    ffmpeg \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Создаем рабочую директорию
WORKDIR /app

# Копируем твой скрипт (исправлено название!)
COPY scriptbyredit.sh /app/
RUN chmod +x /app/scriptbyredit.sh

# Устанавливаем entrypoint
ENTRYPOINT ["/app/scriptbyredit.sh"]
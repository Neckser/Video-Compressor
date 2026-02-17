
# Video Compressor
Скрипт для сжатия MP4 видео с сохранением пропорций. Работает через Docker с FFmpeg.

## Требования
- Docker
- Docker Compose
- bash (для Linux/macOS) или PowerShell/Git Bash (для Windows)

## Быстрый старт

### 1. Клонируйте репозиторий
```bash
git clone <url-репозитория>
cd video-compressor
```

### 2. Запустите скрипт
```bash
./start.sh (может понадобиться chmod +x ./start.sh)
```

Скрипт автоматически:
- Соберёт Docker образ
- Запустит контейнер в интерактивном режиме
- Покажет доступные MP4 файлы

## Структура проекта
```
video-compressor/
├── Dockerfile              # Образ с FFmpeg
├── docker-compose.yml      # Docker Compose конфиг
├── scriptbyredit.sh        # Основной скрипт сжатия
├── start.sh                # Запускалка (build + run)
├── converted/              # Папка для сжатых видео
└── videos/                # Папка для исходных видео
```
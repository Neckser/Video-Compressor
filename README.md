# Video Compressor - Кроссплатформенная версия

Работает на:
- ✅ Windows (PowerShell, Git Bash, WSL)
- ✅ Linux (Ubuntu, Debian, CentOS)
- ✅ macOS (Intel и Apple Silicon)

## Быстрый старт

### Linux/macOS
```bash
# Сделать скрипт исполняемым
chmod +x run.sh

# Запустить
./run.sh
# или
make run
```

### Windows (Git Bash)
```bash
# Запустить
./run.sh
# или
make run
```

### Windows (PowerShell)
```powershell
.\run.ps1
```

## Установка

1. Скопируйте все файлы в папку проекта:
   - Dockerfile
   - docker-compose.yml
   - compress.sh
   - run.sh (для Linux/macOS/Git Bash)
   - run.ps1 (для Windows PowerShell)
   - Makefile

2. Соберите образ:
```bash
docker build -t video-compressor .
# или
make build
```

## Использование

### Интерактивный режим
```bash
make run
# или
./run.sh
```

### Быстрое сжатие
```bash
make compress FILE="video.mp4" SIZE=1.2
```

### Прямой запуск через Docker
```bash
# Linux/macOS
docker run --rm -it -v $(pwd):/workspace video-compressor

# Windows (PowerShell)
docker run --rm -it -v ${PWD}:/workspace video-compressor

# Windows (Git Bash)
docker run --rm -it -v "$(pwd):/workspace" video-compressor
```

## Структура проекта
```
video-compressor/
├── Dockerfile              # Мультиплатформенный Dockerfile
├── docker-compose.yml      # Docker Compose конфиг
├── compress.sh             # Основной скрипт
├── run.sh                  # Запуск для Linux/macOS/Git Bash
├── run.ps1                 # Запуск для Windows PowerShell
├── Makefile                # Универсальный Makefile
└── README.md               # Документация
```

## Принцип работы

1. **Автоопределение платформы** - скрипты сами определяют ОС
2. **Правильные пути** - конвертация путей для Windows
3. **Мультиархитектурность** - работает на Intel и ARM
4. **Простота** - одинаковые команды на всех ОС

## Тестирование

Проверено на:
- ✅ Ubuntu 22.04 (Intel)
- ✅ macOS 14 (Apple Silicon M2)
- ✅ Windows 11 + WSL2
- ✅ Windows 11 + Git Bash
- ✅ Windows 11 + PowerShell
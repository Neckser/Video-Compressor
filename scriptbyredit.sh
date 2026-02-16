#!/bin/bash

# ****************************
# * Скрипт сжатия видео  *
# * Автор: seanbeedelicious *
# * 20250913 Начальная версия *
# ****************************

# Этот скрипт сжимает MP4 видеофайлы в текущем каталоге,
# сохраняя при этом их исходное соотношение сторон.

# Установите максимальный размер для выходного видео (ширина или высота)
# Все видео будут масштабироваться так, чтобы их самая длинная сторона была этого размера.

# Определите выходной каталог
output_dir="./converted"

# Проверьте, установлены ли ffmpeg и ffprobe
if ! command -v ffmpeg &> /dev/null || ! command -v ffprobe &> /dev/null
then
    echo "ffmpeg или ffprobe не найдены. Пожалуйста, установите их, чтобы запустить этот скрипт."
    exit 1
fi

# Создайте выходной каталог, если он не существует
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Показываем доступные MP4 файлы
echo "Доступные MP4 файлы:"
ls *.mp4 2>/dev/null || echo "Нет MP4 файлов в текущей директории"

echo ""
echo "Какой файл вы хотите сжать? "
read file1

# # Проверяем существование файла
# if [ ! -f "$file1" ]; then
#     echo "  - $file1: Исходный файл не найден. Пропускаем."
#     exit 1
# fi

# Исправлено: используем $file1 вместо $file
echo "Обрабатываем $file1..."

base_filename=$(basename -- "$file1")
base_name="${base_filename%.*}"

# Проверяем существование выходного файла
output_file="${output_dir}/${base_name}.mp4"
if [ -f "$output_file" ]; then
    echo "  - $file1: Преобразованный файл $output_file уже существует."
    echo "Хотите перезаписать? (y/n): "
    read answer
    if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
        echo "Выходим..."
        exit 0
    fi
fi

# Исправлено: используем $file1 для определения размеров
in_width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$file1")
in_height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$file1")

if [[ -z "$in_width" || -z "$in_height" ]]; then
    echo "  - $file1: Не удалось определить размеры видео. Пропускаем."
    exit 1
fi

echo "  - $file1: Входное разрешение: ${in_width}x${in_height}"

output_scale="${in_width}:${in_height}"

printf "  - $file1: Входной размер: "
ls -lh "$file1" | awk '{print $5}'

# Сжимаем видео:
echo "  - $file1: Сжимаем..."
echo "-->"
ffmpeg -analyzeduration 2147483647 -probesize 2147483647 -ignore_editlist 1 -err_detect aggressive -i "$file1" -r 30 -vf "scale=$output_scale,format=yuv420p" -crf 28 -preset fast -c:v libx264 -c:a aac -b:a 64k -bsf:v h264_mp4toannexb "$output_file"
echo "<--"

# Исправлено: анализируем ВЫХОДНОЙ файл, а не входной
out_width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$output_file")
out_height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$output_file")

echo "  - $file1: Вывод: $output_file"
echo "  - $file1: Выходное разрешение: ${out_width}x${out_height}"
printf "  - $file1: Выходной размер: "
ls -lh "$output_file" | awk '{print $5}'
echo "Завершено $file1"
echo ""

echo "Скрипт завершен. Сжатое видео находится в каталоге $output_dir"
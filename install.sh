#!/bin/bash

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}    УСТАНОВКА ТВОЕЙ СБОРКИ            ${NC}"
echo -e "${GREEN}========================================${NC}"

# Проверка
if [ "$EUID" -eq 0 ]; then 
   echo -e "${RED}НЕ ЗАПУСКАЙ ЧЕРЕЗ SUDO!${NC}"
   exit 1
fi

# 1. Пакеты
echo -e "${YELLOW}[1/4]${NC} Устанавливаю пакеты..."
if [ -f pkglist.txt ]; then
    sudo pacman -S --needed $(cat pkglist.txt)
fi

# 2. AUR (если есть)
if [ -f aurlist.txt ]; then
    echo -e "${YELLOW}[2/4]${NC} Найдены AUR пакеты:"
    cat aurlist.txt
    echo -e "Установи их через yay/paru вручную"
fi

# 3. Конфиги
echo -e "${YELLOW}[3/4]${NC} Восстанавливаю конфиги..."

# Вся папка .config целиком
if [ -d configs/.config ]; then
    cp -rf configs/.config ~/ 2>/dev/null
    echo -e "  └── .config восстановлена"
fi

# Точечные файлы
if [ -d home ]; then
    cp -rf home/.* ~/ 2>/dev/null
    echo -e "  └── Точечные файлы восстановлены"
fi

# 4. Финал
echo -e "${YELLOW}[4/4]${NC} Завершение..."
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}УСТАНОВКА ЗАВЕРШЕНА${NC}"
echo ""
echo -e "Осталось руками:"
echo "1. Проверь sudo - если надо, добавь пользователя в sudoers"
echo "2. Перезагрузись: sudo reboot"
echo -e "${GREEN}========================================${NC}"

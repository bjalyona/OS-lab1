#!/bin/bash

# Функция для вывода сообщения о правильном использовании скрипта
help() {
  echo "You need to enter the number of users as the first parameter"
  echo "Example: ./3-16.sh"
  echo "After that the program will ask you for the user login prefix, enter it"
}

# Проверка на наличие флага -h (помощь)
if [ "$1" == "-h" ]; then
  help
  exit 0
fi

# Проверка, что введенное количество пользователей является числом
if ! [[ $1 =~ ^[0-9]+$ ]]; then
  echo "Error: The number of users must be a valid number"
  help
  exit 1
fi

# Сохранение первого аргумента в переменную count
count=$1
# Запрос префикса логина пользователя
read -p "Enter the prefix: " prefix

> users.csv #Создаем текстовый файл users.csv

# Цикл для создания пользователей
for ((i=1; i<=$count; i++)); do
  # Формирование имени пользователя с ведущими нулями
  username="${prefix}_$(printf %03d $i)"
  # Генерация пароля с помощью утилиты pwgen
  password=$(pwgen 12 1)
  # Запись имени пользователя и пароля в файл users.csv
  echo "${username},${password}_$(printf %03d $i)" >> users.csv
done

echo "The users.csv file was successfully created"
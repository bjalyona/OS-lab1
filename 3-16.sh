#!/bin/bash

# Запрос префикса логина пользователя
read -p "Enter the prefix: " prefix
# Запрос количества создаваемых пользователей
read -p "Enter the count of members: " count

# Проверка, что введенное количество пользователей является числом
if ! [[ $count =~ ^[0-9]+$ ]]; then
  echo "Error: The number of users must be a valid number"
  exit 1
fi

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
# Тестовое задание для стажировки в Учи.ру

Сервис для управления списком студентов и классов. Реализован на Ruby on Rails и PostgreSQL.

## Технологии
- Ruby 3.3
- Rails 8.1
- PostgreSQL 15
- Docker / Docker Compose

## Как запустить проект локально

Для запуска проекта вам понадобится установленный Docker.

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/Kristina756/uchi_test_task.git
   cd uchi_test_task
2. Запустите проект через Docker Compose:
   docker compose up --build
3. Инициализируйте базу данных (выполните в другом терминале):
   docker compose run web bin/rails db:prepare

Сервис будет доступен по адресу: http://localhost:3000

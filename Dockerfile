# Используем Ruby
FROM ruby:3.3

# Устанавливаем зависимости
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Создаем папку приложения
WORKDIR /app

# Копируем Gemfile и устанавливаем гемы
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копируем остальной код
COPY . .

# Открываем порт
EXPOSE 3000

# Запускаем сервер
CMD ["rails", "server", "-b", "0.0.0.0"]
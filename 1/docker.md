# Деплой проекта с использованием Докер контейнеров.

Docker — программное обеспечение для автоматизации развёртывания и управления приложениями в среде виртуализации на уровне операционной системы
поэтому не позволяет запускать операционные системы с ядрами, отличными от типа ядра базовой операционной системы. 
Docker позволяет «упаковать» приложение со всем его окружением и зависимостями в контейнер, который может быть перенесён на любую Linux-систему.

Требования: Linux (нативный либо в виртуалке).

При использовании Linux в качестве основной ОС смысла разворачивать Докер контейнеры внутри виртуалки (гостевой ОС) смысла нет, т.к. это лишний уровень абстракции.
Поэтому проще поднять контейнеры прямо внутри рабощей ОС.
При использовании же Windows другого способа как развернуть контейнеры внутри VirtualBox нет.

## Установка Docker.

    curl https://get.docker.com > /tmp/install.sh
    chmod +x /tmp/install.sh
    sudo /tmp/install.sh
    
Или проще.

    apt-get install docker.io
    
Чтобы не писать каждый раз sudo в команндах можно добавить текущего пользователя в группу docker.

    sudo usermod -aG docker username
    
Но тогда вы станете рутом, что не безопасно.  

Поэтому если уже добавили то удалить можно так.

  gpasswd -d user group 
  

## Создание проекта Laravel

Дале необходимо выполнить ряд инструкций по загрузке зависимостей и созданию нового проекта
которые описаны по этой [ссылке](manual.md#%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-php-composer)
  
  
## Устанавливаем compose (для удобного управления запуском контейнеров).

Попроще.

    apt-get install docker-compose

Посложнее.

Качаем бинарь.

```
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  
```  
  
Делаем его исполняемым.

```
  sudo chmod +x /usr/local/bin/docker-compose
```
  
Проверяем все ли пучком.

```
  docker-compose --version
```  
  
## Создаем папку для проектов.

```
    mkdir prj
    cd prj
```

## Тянем Laravel. 

```
    composer require "laravel/installer"
```

## Создаем новый проект.

```
    ./vendor/bin/laravel new blog-project
    cd blog-project
```

  
## Создадим docer-compose.yml файл с двумя контейнерами app и database 

```
    version: '2'
    services:

      app:
        build:
          context: ./
          dockerfile: app.dockerfile
        working_dir: /var/www
        volumes:
          - ./:/var/www
        environment:
          - "DB_PORT=5432"
          - "DB_HOST=database"
        container_name: dev_app
        restart: always
        
        
      database:
        image: postgres:9.4
        restart: always
        volumes:
          - dbdata:/var/lib/postgresql/data
        environment:
          - "POSTGRES_PASSWORD=password"
        ports:
            - "5431:5431"
        container_name: dev_database
```     
     
        
## Создадим файл app.dockerfile в корне проекта.

```
    FROM php:7.1-fpm

    RUN apt-get update && apt-get install -y libmcrypt-dev \
        libpq-dev \
        libmagickwand-dev --no-install-recommends \
        && pecl install imagick \
        && docker-php-ext-enable imagick \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install pgsql pdo pdo_pgsql
        
    RUN chown -R www-data:www-data /var/www
```      
  
Поднимаем контейнеры.

  sudo docker-compose up    
    
    
 

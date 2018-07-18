# Начало работы.

Необходимо иметь ОС на базе Ubuntu установленной базово либо внутри виртуальной машины VirtualBox.

## Ручная установка необходимых инструментов.

### Вспомогательные.

    sudo apt-get install git terminator curl git unzip gedit chrome
    
### База.

    sudo apt-get install postgresql

- при работе внутри виртуалки нужны либы для клипборда на Ubuntu

    sudo apt-get install virtualbox-guest-dkms virtualbox-guest-x11
    
Отметить тут и перегрузить машину.

![](/images/1/clipboard.png)

** Соединение ssh клиентом напрямую к виртуалке **

1. Установим ssh сервер.

    sudo apt-get install openssh-server
    
2. Добавим мост.

    ![GitHub Logo](/images/1/1.png)
  

### PHP 7.1

    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install php7.1
    
### Установка зависимостей Laravel.

    sudo apt-get install php7.2-mbstring php7.2-dom php7.2-pgsql php7.2-fpm php7.2-zip


### Установка PHP composer.

- качаем установщик

    curl -sS https://getcomposer.org/installer
  

- устанавливаем композер глобально.

    sudo php installer --install-dir=/usr/local/bin --filename=composer

### Тянем Laravel. 

    composer require "laravel/installer"

    
## Делаем копию .env.example

    cp .env.example .env
    
## Edit database connection.
  
    DB_PORT=5432
    DB_HOST=127.0.0.1
    DB_DATABASE=cms 
    
## Create database    
    
    su - postgres
    createdb cms
    
## Use migrations and seeding.    
    
    php artisan migrate:fresh --seed
    
## PHP-fpm configuration file.    

    sudo nano /etc/php/7.2/fpm/pool.d/www.conf
    
Make sure about the path to the socket file is.

    pid = /run/php/php7.2-fpm.sock
    
    
Make sure that 

    listen.owner = username
    listen.group = username
    
have the save username that in /etc/nginx/nginx.conf

    user username;
    
    
    
    
## NGIX configuration file.


```
    sudo nano /etc/nginx/sites-enabled/e-commerce
       
        
    server {
        listen 80;
        

        root /home/zdimon/www/e-commerce/origin/public/site;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name ecommerce.local;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }        
        
        
    }
    
    
    server {
        listen 80;
        

        root /home/zdimon/storage1/www/e-commerce/origin/public/admin;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name admin.ecommerce.local;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }
        
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }  

        
    }
```    
    
## Alias to the localhost in /etc/hosts (optional).

    
    127.0.0.1	ecommerce.local
    127.0.0.1	admin.ecommerce.local
    
    
    
# Деплой проекта с использованием Докер контейнеров.

Docker — программное обеспечение для автоматизации развёртывания и управления приложениями в среде виртуализации на уровне операционной системы
поэтому не позволяет запускать операционные системы с ядрами, отличными от типа ядра базовой операционной системы. 
Docker позволяет «упаковать» приложение со всем его окружением и зависимостями в контейнер, который может быть перенесён на любую Linux-систему.

Требования: Linux (нативный либо в виртуалке).

## Установка Docker.

    curl https://get.docker.com > /tmp/install.sh
    chmod +x /tmp/install.sh
    sudo /tmp/install.sh
    
Чтобы не писать каждый раз sudo в команндах можно добавить текущего пользователя в группу docker.

    sudo usermod -aG docker username
    
Но тогда вы станете рутом, что не безопасно.  

Поэтому если уже добавили то удалить можно так.

  gpasswd -d user group 
  
## Устанавливаем compose (для удобного управления запуском контейнеров).

Качаем бинарь.

  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  
  
Делаем его исполняемым.

  sudo chmod +x /usr/local/bin/docker-compose
  
Проверяем все ли пучком.

  docker-compose --version
  
Если да, переходим в папку проекта и поднимаем контейнеры.

  sudo docker-compose up    
    
    
 

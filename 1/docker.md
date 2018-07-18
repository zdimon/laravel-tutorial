# Деплой проекта с использованием Докер контейнеров.

Docker — программное обеспечение для автоматизации развёртывания и управления приложениями в среде виртуализации на уровне операционной системы
поэтому не позволяет запускать операционные системы с ядрами, отличными от типа ядра базовой операционной системы. 
Docker позволяет «упаковать» приложение со всем его окружением и зависимостями в контейнер, который может быть перенесён на любую Linux-систему.

Требования: Linux (нативный либо в виртуалке).

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
  
## Устанавливаем compose (для удобного управления запуском контейнеров).

Попроще.

    apt-get install docker-compose

Посложнее.

Качаем бинарь.

  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  
  
Делаем его исполняемым.

  sudo chmod +x /usr/local/bin/docker-compose
  
Проверяем все ли пучком.

  docker-compose --version
  
Если да, переходим в папку проекта и поднимаем контейнеры.

  sudo docker-compose up    
    
    
 

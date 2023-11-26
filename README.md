# hw-11-salt-vagrant
Задание:

добавить в проект salt server;

добавить на конечные ноды миньоны солта;

настроить управление конфигурацией nginx и iptables.


Клонируем проект: git clone https://github.com/alexeykazancev/hw-11-salt-vagrant.git 
скачиваем заранее бокс файл для virtualbox c https://app.vagrantup.com/debian/boxes/bullseye64 (в моем случае deb11 переименовываем скачанный бокс в bullseye.box), положить в папку с проектом

для запуска деплоя выполнить vagrant up

для проверки статуса развернутых вм выполнить vagrant status

после проверки коннектимся к в мастеру: vagrant ssh master-node
внутри машины выполняем команду: sudo salt-key -F master
копируем содержимое строки master.pub:

идем на миньен: vagrant ssh minion-node 
открываем файл: sudo nano /etc/salt/minion ищем строку ( master_finger: '') разкоменчиваем её и вставляем туда сожержимое master.pub: из предыдущего шага

рестартуем миньен sudo sytemctl restart salt-minion.service

подключаемся к мастеру vagrant ssh master-node

выполняем: sudo salt-key -L
в поле  Unaccepted Keys: minion-node  должен появиться наш миньен

выполняем принятие: sudo salt-key --accept='minion-node'
проверяем, что он добавился: sudo salt-key -L
выполняем пинг: sudo salt '*' test.ping

цепляемся к master-node: vagrant ssh master-node
клонируем проект на хост: git clone https://github.com/alexeykazancev/hw-11-salt-vagrant.git
переходим в каталог салт: cd salt/
внутри должны быть файлы nginx.sls и nginx.conf

для запуска установки nginx выполнить: sudo salt 'minion-node' pkg.install nginx
для проверки корректности установки выполнить: sudo curl 192.168.56.5


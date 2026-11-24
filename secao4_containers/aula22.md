**para rodar nginx**

docker container run --publish 80:80 --name teste_nginx --detach nginx

**para rodar httpd(apache)**
docker container run --publish 8080:80 --name teste_apache --detach httpd

**para rodar mysql**
docker container run --publish 3306:3306 --name teste_mysql --detach mysql

PESQUISAR COMO FAZ PARA RODAR COM --env em mysql

exemplo do proprio docs do docker:
Set a variable directly:
docker run --env VAR1=value1 ubuntu env | grep VAR1
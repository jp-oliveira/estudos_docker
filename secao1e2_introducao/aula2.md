## Passos

1. Fazer uma conta no dockerhub

Comandos em algum play with docker (usei o do killer coda):
docker run -d -p 8800:80 httpd
docker run -d -p 8801:80 httpd

OBS: SE EU REPETIR NA MESMA PORTA 8800 por exemplo 2 vezes daria erro.

-p = Pegue esse container e encaminhe qualquer tráfego na porta pública do ip do host para esse container.

É por isso que podemos atribuir a porta externa 80 para encaminhar o tráfego dentro do container um e, em seguida, para o segundo

curl localhost:8800
docker ps

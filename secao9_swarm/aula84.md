>Criando um swarm com 3 nós

Há 4 formas:

1 - play-with-docker.com
    funciona em qualquer browser, porém reseta depois de 4 horas.

2 - Docker-machine + VirtualBox
    de graça e roda localmente, mas exige uma máquina com 8G de ram que serão destinados para o virtualbox.

3 - Digital Ocean + Docker instalado
    Se parece com uma configuração de produção, mas tem um custo. O professor dá um cupom para um mês de graça.

4 - Rodar da sua própria maneira
    docker-machine pode subir maquinas pela amazon, azure, DO, google, etc.

O preferível é que todos os 3 nós estejam na mesma network.

OBS: Docker-machine ainda não foi visto no curso. é um CLI (Command line tool) que já vem instalada no docker para windows e mac. É basicamente uma ferramenta de automação para ter máquinas virtuais localmente e na internet, automaticamente configurando o docker.

Por padrão o docker-machine funciona com VirtualBox, que pode ser instalado gratuitamente. Mas cai no que foi falado, consome muita ram.

O play-with-docker foi descontinuado, uma alternativa e usar o https://labs.iximiuz.com/.  Pesquisar a tecnologia docker-in-docker

Se for usar docker-machine e virtualbox:
> docker-machine create node1

Tentei de todas as formas alternativas online para swarm, mas nenhuma de fato dá a possibilidade de ter máquinas com hostname e ips diferentes. 

Mas para fazer teria que criar baseado no que o gpt sugere:

abrir o 1 terminal e fazer:
> docker swarm init --advertise-addr IP_DO_MANAGER

Esse advertise addr é para saber por qual ip as máquinas do nó vão te achar.

Para saber o ip basta ver em hostname -i ou -I.

Abrir um novo terminal e a partir dele fazer
> docker swarm join --token SWMTKN-1-xxxxxxxx IP_DO_MANAGER:2377

obs: esse token é armazenado, não se preocupe se perdê-lo. Pesquisar depois como acessa-lo sem se preocupar em perder o comando.

No 3, fazer a mesma coisa:

> docker swarm join --token SWMTKN-1-xxxxxxxx  10.0.0.5:2377

Depois de fazer tudo isso, voltar ao manager e rodar 
> docker node ls

Você verá os workes e o próprio manager.

Para distribuir um serviço ente os nós:

> docker service create \
  --name ping \
  alpine \
  ping 8.8.8.8

rode agora:
> docker service ls
o modo estará como replicado

> docker service ps ping
aparecerá lá.


Agora façamos o que o swarm veio fazer: o pegar um serviço e distribuir suas tarefas pelos nós do cluster.

> docker service scale ping=6
SE QUISER PODE RODAR COM O UPDATE VISTO NA AULA 81.

agora rode
>docker service ps ping

Verá a distribuição dos serviços entre os workers e os managers.

Ou para ver também faça:
> docker node ps node2
> docker node ps node3

OBS:
docker run alpine ..... É DIFERENTE DE 
docker service create alpine.....

O primeiro cria um container isolado naquele Docker Engine. O segundo cria uma tarefa gerenciada pelo Swarm, que pode ser distribuída pelo cluster.

get-docker.com = um site que também foi descontinuado para pegar exemplo de scripts

OBSERVAÇÃO: APENAS O MANAGER pode fazer
> docker node ls
e outros comandos. Se você tentar nos workers você não vai conseguir.

para o manager mudar quem é o manager e passar a ser worker:
> docker node update --role manager node2 
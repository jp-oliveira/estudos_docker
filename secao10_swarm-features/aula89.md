# Teste de swarm

- Fiz o manager e os nodes pelas dicas do gemini.

>docker run -d --privileged --name manager --hostname manager docker:dind
>docker run -d --privileged --name worker1 --hostname worker1 docker:dind
>docker run -d --privileged --name worker2 --hostname worker2 docker:dind

dind é o famoso docker in docker, mesma maneira que o antigo play-with-docker fazia.

## Cria uma rede para o cluster (ip escolhido para evitar conflitos)

> docker network create --subnet=172.25.0.0/16 swarm-net

## Conecta os dois containers a essa rede

> docker network connect swarm-net manager
> docker network connect swarm-net worker1
> MANAGER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAdzess}}{{end}}' manager)
faça depois echo $MANAGER_IP para verificar se achou o MANAGER_IP. Se não achou, faça docker inspect manager para descobrir IPAddress. então, sete MANAGER_IP para esse ip caso ele não tenha achado.

> docker exec -it worker1 docker swarm join --token SEU_TOKEN_AQUI $MANAGER_IP:2377
> docker exec -it worker2 docker swarm join --token SEU_TOKEN_AQUI $MANAGER_IP:2377

# Para testar se os nós foram criados corretamente

> docker exec -it manager docker node ls

Sobre o teste agora:
Em produção não dá pra ficar buildando nada, portanto suba as imagens que você vai trabalhar para o dockerhub.

No teste, o python é o frontend, a porta de entrada do usuário ao sistema.

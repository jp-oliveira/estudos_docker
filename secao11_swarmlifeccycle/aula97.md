>Segredos com compose

"Simulação" local de segredos

- Lembrando = docker compose não é uma ferramenta de produção, é uma ferramente de dev pois builda.

## ainda se atendo ao secrets-sample-2

Podemos, mesmo sem ter o swarm ativado, usar o mesmo arquivo compose, os mesmos objetos, mesmos envs, etc. Faremos:
> docker compose up -d
e obviamente não
> docker stack deploy -c stack_name

Porém se fizermos, dentro do container por exemplo:
> docker-compose exec psql cat /run/secrets/psql_user

verá que há um segredo ali. Como??

O que acontece não é seguro, mas funciona.

Basicamente, isso faz um *bind mount* daquele arquivo real do meu disco rígido para dentro do contêiner em tempo de execução.

Está fazendo um -v com o arquivo particular em background.

Isso não é seguro e não deveria acontecer, é só uma forma de contornar o problema e permitir desenvolver com o mesmo processo e o mesmo env que teríamos em produção.

Apenas agora podemos ter localmente tbm, o que é ótimo pq agora isso significa que podemos desenvolver com os mesmos script e mesma forma que teríamos env no nosso container como tem no swarm.

Pq na verdade essa é a intenção. Queremos fazer com o que o ambiente local se pareça o máximo possível com o ambiente de produção.

Isso só funciona com a versão 11 do compose.

Pontuando: só funciona com segredos baseados em arquivo, não com segredos externos.

## Healthcheck

Suportado in dockerfile, compose YAML, docker run e serviços swarm

Recomendação para produção: testar o healthcheck de várias maneiras.

Esse comando funciona logo de cara com um exec. Vai rodar DENTRO do contianer, não fora. Até mesmo em workers que não tem porta exposta é possível rodar um comando simples para verificar se estão retornando dados corretamente ou não.

Espera 0 (OK) ou 1 (Error). Quase sempre, em docker, o que não é 0 está com algum erro, exceto em um app específico (será falado mais a frente).

Só há 3 estados para healthcheck:

starting = primeiros 30 segundos por default, quando ainda não rodou um comando healthcheck. Retorna 1.
healthy = retorna 0.
unhealthy = retorna 1.

A cada 30 segundos o comando roda. A qualquer erro, ele retorna 1.

O healthcheck não fornece gráficos, status overtime ou qualquer ferramenta de terceiros esperada para um cenário de monitoramento.

Ele é sobre o docker entender simplesmente se o container está ou não saudável.

Em un nginx por exemplo, retorna um localhost do arquivo index. Um retorno de 200 ou 300 está ok, indicando healthy.

Mas se retornar 404 ou erro 500, está obviamente unhealthy.

Aone ver portanto o checa saúde?

> docker container ls
cheque os últimos 5 healthchecks com
> docker container inspect

A grande vantagem do serviço para o container:
Os serviços vão SUBSTITUIR tarefas se o healthcheck falhar.
Isso também acontece nos updates. Ele vai verificar o healthcheck. Se o healthcheck não retornar 0, ele não vai subir.

ex:
```bash
docker run \
    --health-cmd="curl -f localhost:9200/_cluster/health || false" \
    --health-interval=5s \
    --health-retries=3 \
    --health-timeout=2s \
    --health-start-period=15s \
    elasticsearch:2
```

Estamos implementando um healthcheck em uma iagem que não tem esse comando. Perceba que o comando é somente um curl para a porta do container, não para a porta publicada.

O "|| false" no final é muito comum com curl, pois ele retorna um código de erro diferente de 1. O que precisamos é somente do 1 para o docker entender que está unhealthy.

Já em dockerfiles podemos fazer assim:
> interval=DURATION (default: 30s)
> timeout=DURATION (default: 30s)
> --start-period=DURATION (default: 0s) (17.09+)
> --retries=N (default: 3)

intervalo = frequência que o comando vai rodar.
timeout = quanto tempo vc vai esperar até que o erro surja e retorne um código de erro (pense que o app pode estar lento).
start-period = Depois de quanto tempo que ele vai rodar o PRIMEIRO healthcheck. Necessário pois há imagens que podem demorar mais tempo para subir.
retries = Quanto tempo vai tentar até constatar que está de fato unhealthy. Imagine que o seu app pode estar instável em algum momento.

Comando básico de healthcheck:
> HEALTHCHECK curl -f http://localhost/ || false
comando customizado:
> HEALTHCHECK --timeout=2s --interval=3s --retries=3 \ 
>   CMD curl -f http://localhost/ || exit 1

Repare que para customizar o checasaude precisamos usar o CMD.

Exemplo agora se fosse no dockefile. Um site estático rodando em nginx, apenas testando:

```Dockerfile
FROM nginx1:13
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1
```

exit 1 e false SÃO A MESMA COISA.

## PHP-FPM rodando pelo Nginx, testar o nginx e FPM status URLs

```Dockerfile
FROM your-nginx-php-fpm-combo-image
# don't do this if php-fpm is another container
# must enable php-fpm ping/status in pool.ini
# must forward /ping and /status urls from nginx to php-fpm

HEALTHCHECK --interval=5s --timeout=3s \    
    CMD curl -f http://localhost/ping || exit 1
```

Nesse caso acima é um arquivo config do nginx que usa nginx e status URLs do PHP-FPM.
As 2 aplicações tem sua própria página de status e tipo um ping de URL para o healthcheck.
Podemos usá-los nos nossos apps se estivermos trabahando com PHP ou Nginx. Há 2 URLs diferentes, mas podemos usar ambas dentro do mesmo healthcheck.

No caso acima, estamos usando apenas uma e jogando em localhost/ping, que é na verdade um comando de status PHP-FPM, porém temos que permiti-lo dentro do nosso PHP-FPM.

Para mais detalhes, testar com o projeto abaixo:

[projeto_php](https://github.com/BretFisher/php-docker-good-defaults/blob/master/docker-compose.yml)

Por últmo, um exemplo em Postgres, onde podemos usar uma URL diferente.

```Dockerfile
FROM postgres
#specify real user with -U to prevent errors in log
HEALTHCHECK --interval=5s --timeout=3s \
    CMD pg_isready -U postgres || exit 1
```

No caso ESPECÍFICO do postgres, o comando pg_isready ja vem na própria imagem, é um teste simples de conexão com um servidor postgres. IMPORTANTE: esse comando não valida nada, ele só checa se o servidor da base de dados permite conexões.

Exemplo num arquivo compose.yaml:

```YAML
version: "2.1" #(minimum for healthchecks)
services:
    web:
        image: nginx
        healthcheck:
            test: ["CMD", "curl", "-f", "http://localhost"] 
            interval: 1m30s
            timeout: 10s
            retries: 3
            start_period: 1m #version 3.4 minimum
```

Vendo agora no cmd:

>docker container run --name p1 -d postgres
> docker container ls
se eu simplesmente subir um container postgres, verá que no docker container ls não há nenhuma coluna de healthcheck.

rodando agora com healthcheck manualmente:
> docker container run --name p2 -d --health-cmd="pg_isready -U postgres || exit 1" postgres

> docker container inspect p2
Veja a propriedade Health agora lá, que NÃO aparecerá se inspecionarmos o p1.

Fazemos agora o teste com serviços. Também podem ter 3 status:
preparing = está baixando a imagem
starting = está executando e subindo o container
running

>docker service create --name p1 postgres
> docker service create --name p2 --health-cmd="pg_isready -U postgres || exit 1" postgres

Da 2 maneira ele vai demorar 30s até rodar de fato.

quiz:
In order to spin up multiple services in a Swarm, we can just use 'docker-compose up' and Docker will be able to tell this is a Swarm and will deploy services across all nodes.
A sua escolha de "False" está correta porque o comando 'docker-compose up' não é capaz de interagir com o Swarm. Em vez disso, utilizamos o comando 'docker stack deploy' para implantar serviços em um cluster Swarm a partir de arquivos YAML.
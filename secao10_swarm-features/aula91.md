>Stacks

Stacks é basicamente um compose files para swarm em produção. Foi adicionado na versão 1.13 do swarm, é uma nova camada de abstração.
Stacks aceita compose Files. Dentro delas tem uma coisa chamada "Declaração definitiva" para serviços, redes e volumes. Lá nós definimos e falamos onde queremos que o resultado esteja. É papel do swarm fazer isso.

Portanto, agora não se trata somente de serviços, mas também de redes e volumes. Também existem os segredos, que falaremos depois.

Agora usaremos
> docker stack deploy
ao invés de docker service create. Importa o compose file e roda o comando que colocamos nele.

Não precisa se preocupar em criar por exemplo volumes e redes antes ou depois. Faremos tudo que o swarm fará o resto do trabalho por nós. Há também uma coisa chamada External no nosso arquivo compose para informar o que já existe e não precisa ser criado;

Agora pensaremos com deploy e não com build. Novamente, buildar em produção não está nas boas práticas. Também informaremos quantas réplicas queremos, o que será feito quando cair alguma coisa, quando subiremos um update.

Porém em ambiente de localhost Compose agora ignora deploy. Swarm, por sua vez, ignora comandos build.

docker-compose cli não é necessário em servidores swarm. Swarm é basicamente a Docker Engine. Portanto, compose files agora são aceitados pela docker engine usando o comando stack. Lerá compose files sem precisar de docker compose no servidor.

Também haverá labels (mais metadados) para saber de qual stack alguma coisa é oriunda.

Um Stack é para apenas um swarm.

OBS: para lidar com stack em arquivos YML, docker precisa estar na versão 3 ou maior.

***OBSERVAÇÕES SOBRE O ARQUIVO DE SWARM-STACK-1:***

- Reparar na tag deploy. é uma novidade.

- Agora temos update_config, que nos permite configurar uma série de funcionalidades que não conseguíamos antes, como delay e parallelism, oque acontece quando eu faço um update, como queremos que os updates atinjam os serviços, etc.

- Restart_policy = o que fazer quando o serviço cair.

- Também podemos especificar na tag constraints algumas especificidades como por exemplo em qual node queremos que algum serviço rode.

> docker stack deploy -c example-voting-app-stack.yml voteapp

docker stack também tem vários comandos próprios, assim como docker image, run, container, etc. ex:

> docker stack --help
> docker stack ls
como cada stack tem um nome, ali serão listadas somente as stacks e quantidade de serviços.
> docker stack ps NOME_DA_STACK
serão listados as tasks da stack específica. E não os containers. Verá os nós que eles estão rodando.

>docker stack services NOME_DA_STACK
similar ao docker service ls, porém especificados agora a uma stack.

Podemos mudar o arquivo YML e depois fazer o mesmo comando feito para iniciar a stack. O docker perceberá os updates e irá realizar as alterações.

- Agora na porta 8080 terá um visualizer dos serviços!!!
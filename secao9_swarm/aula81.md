>Primeiro serviço

Rode docker info e perceba que o swarm está desativado. swarm: inactive.

Para ativar: docker swarm init. Pronto.

Mas o que de fato aconteceu quando esse comando foi feito?

Faz várias ações envolvendo PKI (public key infrastucture) e segurança.

Cria um certificado root para o swarm que será usado para estabelecer confiança e assinar certificados para todos os nodes e todos os managers.

Cria tbm um certificado especial para o manager do primeiro node porque é um gerente VS worker.

Além disso, cria também tokens que podem ser usados em outros nós para entrar nesse swarm.

Outras coisas tbm são criadas em background a fim de permitir o swarm API e cria o Raft Consensus Database, que será visto mais pra frente. Raft é basicamente um protocolo que assegura consistência entre múltiplos nós, muito usado em nuvem.

Cria a base de dados em disco. Armazena a configuração do swarm e do primeiro manager e encripta (versão 1.13 ou mais atual). Então, espera por outros nós antes de começar a replicar a base de dados para eles. Portanto, todo o tráfego depois que os nós forem criados vai ser encriptado.

Outra característica do swarm é não precisa de um sistema de storage key value ou alguma arquitetura de base de dados para ser a configuração de backend do nosso swarm. (isso é mencionado pq muitas vezes há um db config que guarda configurações de orquestração. Não é o caso). Com isso, swarm colocou tudo no daemon do docker, facilitando a vida.

COMANDOS IMPORTANTES:
docker node ls

Assim que fizer docker swarm init só haverá um nó.

Só pode haver um nó com status Leader entre os gerentes.

docker node --help

promote -> o nó vai de worker pra manager
demote -> o nó vai de manager para worker

docker swarm --help (será comentado em outras aulas)

docker service --help

Service em swarm substitui docker run

Não nos importamos muito com os nós individualmente. Serão só números. Apenas botamos para rodar e o próprio swarm faz a orquestração;

ex1:
docker service create alpine ping 8.8.8.8

Agora rode docker service ls. Ele estará lá.

EM REPLICAS

x/y
x = quantos services estão rodando
y = quantos você especificou para rodar

A meta para a orquestração é igualar x com y, não importa o que seja necessário.

docker service ps NOME ou ID

vai listar as tasks (ou containers) para esse serviço. Semelhante ao docker container ls. Uma diferença é a coluna NODE. Ela é necessária para esse contexto de vários cenários, pois precisamos saber em qual servidor está rodando.

PERCEBA QUE o nome do serviço é o nome do nó com .1 no final. docker container ls tem outro nome de container, mas isso será explicado mais a frente.

Outro comando importante:

> docker service update NAME_OU_ID --replicas 3
> docker service ls

verá que agora está 3/3 em REPLICAS.

> docker service ps NAME_OU_ID
verá que agora há 3 serviços.

Repare que os 2 últimos foram criados mais recentemente. Como queria 3 réplicas e 1 serviço já existia, 2 novos foram criados.

Se fossemos muito rápido, em docker service ls poderíamos ver 1/ ou 2/3, porque as réplicas ainda estariam subindo e sendo configuradas. Questão de segundos.

> docker update --help
comando para trabalhar com RAM, CPU coisas mais específicas e técnicas.

> docker service update --help
tem váaaaarias opções. Um dos papeis do swarm é substituir containers e atualizar mudanças sem derrubar nada. Por isso tantas possíveis ações.

Se eu fizer agora docker container ls, também teremos 3 containers.

E se eu derrubar um container PROPOSITALMENTE?

docker container rm -f NAME

docker service ls
SE AGIR RAPIDAMENTE: VERÁ 2/3 em replicas (na minha máquina nada mudou, verificar se é uma questão de versões)

Mas logo depois ficará 3/3, porque o swarm automaticamente sobe outra task.

veja em docker service ps NAME_OU_ID

que terá uma task lá com o status Failed e estado Shutdown.

Para realmente derrubar um serviço - faça docker service rm. Verá que logo depois com docker service ls os containers sumiram, porém com docker container ls podem demorar mais alguns segundos.
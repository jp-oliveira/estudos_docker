>Overlay Multi-Host

OBS: Nos scripts abaixo você só verá nós diferentes se estiver aplicando o que foi falado nas aulas passadas.

há um novo driver de rede chamado overlay.

Pode criar como sempre cria um network colocando --driver overlay. Vai atuar como uma rede ponte para todo o swarm, onde os containers nessa mesma rede podem se acessar mutuamente como se estivessem numa VLAN.

Essa rede será somente INTRA comunicação, ou seja, o driver overlay não vai lidar com a quantidade de infos que chegam no swarm de fora. Ele na verdade vai estar focado em funcionar globalmente dentro do swarm, justamente para que não se preocupe com as configurações dos nós individualmente.

Também pode-se ativar a criptografia de rede completa usando IPSEC (AES), onde o swarm configurará túneis IPSEC entre todos os nós do swarm. Porém é off por default, somente por motivos de desempenho.

Cada serviço pode ser conectado a múltiplas redes, a depender do design da aplicação. Por exemplo, bd numa rede conectado ao backend e os servidores web frontend conectados em outra.

> docker network create --driver overlay nome_rede

>docker network ls

perceba a nova rede lá criada

> docker service create --name psql --network nome_rede -e POSTGRES_PASSWORD=minha_senha postgres

Perceba que não haverá nenhum download sendo executado, pois serviços não podem rodar em foreground, pois devem passar pelo orchestrator e scheduler. Logo, rodam em background.

> docker service create --name drupal --network mesma_rede -p 80:80 drupal

>docker service ls

DICA: USAR O COMANDO:
>watch docker service ls
Watch é um comando nativo do linux, que se atualiza a cada 2 segundos. É bom para esperar o replicas atualizar de 0/1 para 1/1. para sair, ctrl + C. Anyway, você verá agora 2 serviços.

> docker service ps psql
> docker service ps drupal

Verá que ambos estão rodando em 2 nós diferentes. Como então eles vão se comunicar? quando for instalar o drupal, basta informar o nome do serviço corretamente.

Se você acessar os 3 nodes configurados anteriormente, vai ver que o site estará lá rodando. Mas como?
mesmo se fizer docker inspect serviço, você verá que ele estará rodando em um ip só. Mas como isso é possível? aula seguinte.

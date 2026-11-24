
# Muitos projetos iniciais de container eram muito grande no seu escopo

- Soluções que vc talvez provavelmente não precise no dia um:
  - CI/CD implementado completamente;
  - Dynamic performance scaling;
  - Contaneirizar tudo ou nada;
  - Começar contaneirizando dados persistentes. NÃO começe contaneirizando bd's. Você vai ter muito mais benefícios se começar com algo que vc atualiza/ faz deploy todo dia/toda semana, além de ser bem mais fácil de lidar.

- Apps legados também funcionam em container.
  - Conversão de microserviços não são obrigatórias;
  - 12 Factor é um horizonte que sempre estamos perseguindo. Orquestração é uma meta, não necessariamente já tem que estar implementado para colocar em prd.
  - Não deixe seus "ideais" atrasarem containeirização.

- No que focar primeiro: Dockerfiles
  - Mais importantes do que orquestração elegante ou CI/CD complexo implementado;
  - É sua nova documentação de build e ambiente.
  - Estude Dockerfile/Entrypoint de hub oficias;
  - USe distribuições FROM oficiais;

- Modelo de maturidade do Docker
  - Primeiro faça rodar, começe a aplicação (MVP) e mantenha funcionando.
  - Depois que tudo estiver rodando  e funcionando, se preocupe com logs. Como tirar o log desse container. não coloque em logfiles, está fora do padrão. Coloque em stdout/stderr. Deixe o docker/ sua orquestração lidar com logs, não deixe na sua aplicação. Deixe isso com a sua infraestrutura.
  - Deixe as coisas documentadas. Documente a área do Dockerfile. Não vai lerdar o seu build do dockerfile pois essas linhas são "pulled out" antes do build. Também não vai lerdar produção.
  - Deixe sua app funcionando para os outros;
  - Deixe sua aplicação enxuta. Não tem problema se a sua imagem tem 500 ou 300 Mb. Deixe essa preocupação para depois, se preocupe mais com a qualidade do dockerfile. Se a sua aplicação está cheia de apt-get, não precisa necessariamente mudar tudo para um gerenciador de pacotes diferentes em alpine. Garanta primeiro a que funciona e depois faça outros subprojetos a partir desse primeiro para ir melhorando.
  - Deixe sua aplicação escalável = não é porque uma app roda em 1 container que vai rodar em 5. Talvez haja questões como session state que devem ser levadas em conta.

---------------------------------------------------------------------------------------------------------------------

## Antipadrões do Dockerfile

### 1 - Trapping Data

  Problema: Armazenar dados únicos em container.
  Solução: Definir VOLUME para cada location.
  Há pessoas que acidentalmente esquecem de adicionar extra dark volumes para talvez debugar logs ou air dump logs, é como esquecer stdout ou talve em um arquivo estático, como upload dos usuários ou arquivos de cache que querem que se mantenha entre os diferentes loads do app.
  Para então se certificarem que esses arquivos mencionados estão em volumes se estiver usando imagens oficiais, todos os dados persistentes já terão volumes para você tomar conta.

```Dockerfile
VOLUME /var/libmysql
ENTRYPOINT  ["docker-entrypoint.sh"]
CMD ["mysqld"]
```
  
### 2 - Se você estiver usando imagens com a tag Latest, PARE DE USAR. Saiba as versões que vc está usando

Olhe o primeiro exemplo de dockerfile: quem for ver esse arquivo não precisa adivinhar ou descer milhares de linhas para descobrir as versões dos programas usados. Estão bem descritas. Não esqueça de fazer isso, se usar latest você pode se deparar com um cenário que alguns programas podem parar de funcionar aleatoriamente.

Já na segunda está sendo especificado a versão atualizada de alguns apt-get.

```Dockerfile
FROM php:7.0.24-fpm
ENV NGINX_VERSION 1.12.1-1~jessie \
    NJS_VERSION 1.12.1.0.1.10-1~jessie \
    COMPOSER_VERSION= 1.5.2 \
    NODE_VERSION 6.11.4
```

```Dockerfile
FROM ubuntu:xenial-20170915
RUN apt-get update && apt-get-install \
    ca-certificates \
    g++ \
    ldap-utils= 2.4.40+dfsg-1+debu3 \
    libedit-dev=3.1-20140620-2 \
```

### 3 - Deixar a configuração Default

Problema: Não mudar a configuração, ou copiando cegamente configuração VM. Ex: php.ini, mysql.conf.d, java memory
Solução: Atualizar configurações default via ENV, RUN e ENTRYPOINT

Agora, configurações como buffer, logsize são responsabilidades do Dockerfile. Um bom exemplo do que fazer está no script abaixo ou também usando ENTRYPOINT (lembre-se que roda antes do CMD).

Basta olhar para as imagens oficiais do mysql ou do postgres - Todas setam várias configurações e depois a bd restarta no comando. Não hardcore as variáveis de ambiente dentro do docker build. Deixe para rodar em tempo de execução.

```Dockerfile
ENV MYSQL_ALLOW_EMPTY_PASSWORD= true \
    MYSQL_DATABASE=sysbench \
    MYSQL_CONFIG=/etc/mysql/mysql.conf.d/mysql.cnf \
    MYSQL_BUFFERSIZE=18G \
    MYSQL_LOGSIZE=512M \
    MYSQL_LOG_BUFFERSIZE=64M \
    MYSQL_FLUSHLOG=1 \
    MYSQL_FLUSHMETHOD=O_DIRECT

RUN echo "innodb_buffer_pool_size = ${MYSQL_BUFFERSIZE}" >> ${MYSQL_CONFIG} && \
    echo "innodb_log_file_size = ${MYSQL_LOGSIZE}" >> ${MYSQL_CONFIG} && \
    echo "innodb_log_buffer_size = ${MYSQL_LOG_BUFFERSIZE}" >> ${MYSQL_CONFIG} && \
    echo "innodb_flush_log_at_trx_commit = ${MYSQL_FLUSHLOG}" >> ${MYSQL_CONFIG} && \
    echo "innodb_flush_method = ${MYSQL_FLUSHMETHOD}" >> ${MYSQL_CONFIG} 
```

### 4 - Ambiente Específico

Problema: Copiar a configuração do ambiente no build da imagem;
Solução: Um Dockerfile com ENV's default e sobrescrever com um script ENTRYPOINT

Repare no script abaixo: a depender do ambiente, eu rodo um comando de copy diferente. Não é legal. Sete essas variáveis com entrypoint em tempo de execução.

```Dockerfile
FROM node:6.10
COPY test-environment.json test-environment.json
# COPY dev-environment.json dev-environment.json
# COPY prod-environment.json prod-environment.json
```

---------------------------------------------------------------------------------------------------------------------

## As 3 Grandes decisões

### 1 - Containers em VM ou Containers em Bare Metal

OBS: (contêineres em bare metal = em hardware dedicado) significa executar contêineres diretamente em um servidor físico, sem utilizar uma camada intermediária de máquinas virtuais (VMs) ou hipervisores. Tem a vantagem de entregar 100% da potência bruta (raw power) do processador e da memória.

Container em VM's são instâncias virtualizadas (como na AWS EC2, Google Cloud, DigitalOcean ou um Hyper-V/Proxmox local) que rodam em cima de um hipervisor.

Ambos tem prós em contras. Faça aquele que vc sabe, no qual vc é bom.

A menos que você faça parte do pequeno grupo de pessoas que realmente precisa da potência bruta de hardware dedicado, hoje em dia você provavelmente estará em uma situação melhor usando VMs do que tentando usar e implantar hardware dedicado de forma dinâmica.

Faça alguns testes básicos de performance. Se vc está acostumado com uma abordagem, teste a outra em termos de escala. Escale o número de containers na outra abordagem e compare. Dá pra fazer comparações com testes simples, não precisa fazer nada complicado.

Lidar com um grande número de containers em bare metal é mais complexo pq gerenciar hardware físico de forma dinâmica é extremamente difícil e custoso.

Com VMs na nuvem ou em um ambiente virtualizado moderno, você consegue criar, destruir, redimensionar, clonar e automatizar servidores em segundos via API ou código (IaC - Infrastructure as Code).

Fazer o mesmo com servidores físicos exige infraestrutura física real, tempo de rack, configuração de BIOS/UEFI, gerenciamento de RAID, PXE boot e manutenção de peças que estragam (fonte, HD, memória). Para 95% das empresas, o ganho de agilidade e automação das VMs compensa muito mais do que a pequena perda de performance.

Aumentar o número de container em VM resulta em algumas preocupações, como kernel scheduling, kernel settings e netowk settings

### 2 - SÓ É RELEVANTE SE ESTIVERMOS FALANDO DE DISTRIBUIÇÕES LINUX

A distribuição linux não tem tanta importância. Não importa tanto quanto o kernel. Pq?

- Docker é muito dependente do kernel e do driver de armazenamento;
- Inovações/fixes ainda estão acontecendo aqui. Não use um kernel muito antigo, pois:
- Versão mínima !== Melhor Versão.

Não é somente porque funciona que você vai continuar utilizando. Apache por exemplo funciona muito bem em qualquer distribuição; Docker não. Prefira kernels 4 do que na versão 3 (CONTEXTO DE 2017)

- SE não souber qual distribuição usar opte pela UBUNTU. Não se trata de ter uma distro favorita e sim de ser bem documentado, já foi testado massivamente e suporta kernels 4.x e é a distribuição oficial do docker.

- Teste também Infra kit ou LinuxKit. Pode não ser a mais rápida e pode atrasar um pouco o projeto pq exige uma familiaridade com buildar sua própria distro. De qualquer forma, teste imagens oficiais.

### 3 - Qual imagem deve ser usada no FROM??

- Não tome essa decisão pensando somente no tamanho da imagem.
- Faça um match com o seu projeto existente.
- Considere mudar para Alpine mais tarde, por ser mais leve. kkk

-------------------------------------------------------------------------------------------------------;

## Padrões bons - Arquitetura Swarm

Veremos:

- Testes internos do Docker
- Arquiteturas de referência do Docker
- Deploys do mundo real
- Lições aprendidas do Swarm3k

### BABY SWARM: 1-Node

- DOCKER SWARM INIT - Feito!!
- VM's sozinhas podem fazer
- Te dá mais funcionalidades do que somente docker run (Secrets, configs, services que podem se substituir caso dê algum problema, healthchecks)

### HA Swarm: 3-Node

- NÃO trabalhe com um número par de nodes. Pelo menos para managers.
- Todos são managers
- Mínimo para HA, é o mínimo para uma tolerância de falha;
- Um nó pode falhar;
- Usar quando seu orçamento for bem baixo;
- Projetos pequenos ou Test/CI

### Biz Swarm: 5-Node

- Recomendo para startups que querem uma infra mínima para alta disponibilidade. Não há ainda uma preocupação tão grande com segurança e limitações (boundaries) em torno dos managers. O foco maior é em alta disponibilidade.
- Um nó pode sair momentaneamente para manutenção por exemplo. Na verdade até dois nós podem cair.
- Ainda se tratando de todos os nós sendo managers

### Flexy Swarm: 10+ Nodes

- 5 Managers dedicados. Podem ou não estar numa VLAN diferente. Podem comunicar entre si
- Workers em DMZ
- Qualquer coisa além de 5 nós fica com 5 managers e o resto de worker. Pode ter tantos workers quanto for necessário.
- Controle de substituições de containers com labels + constraints. Constraints são basicamente metadados que te permitem dizer a um serviço que um SSD é necessário ou até mesmo um perfil de segurança ou whatever. Quanto aos labels,podem ser úteis para explicitar alguma info por exemplo da VPN

NOTA: Uma DMZ (Zona Desmilitarizada ou rede perimetral) é uma sub-rede isolada que fica posicionada entre a rede interna (LAN) de uma organização e uma rede não confiável, como a internet.
O objetivo principal é permitir que usuários ou serviços externos acessem recursos públicos sem que eles tenham acesso direto à rede privada sensível.

### Swole Swarm: 100+ Nodes

- Segue um raciocínio parecido com a arquitetura acima.
- 5 managers dedicados
- Redefina a quantidade de managers conforme o sistema for crescendo; São escaláveis porque vc está armazenando RAFT Database. Quanto maior o sistema e mais trabalho tiver, o raft vai ser maior. Podemos tirar um manager ou outro da arquitetura em apenas algumas linhas.
- Múltiplas subredes de workers em privado/DMZ;
- Controle de substituições de containers com labels + constraints.

NOTA: Raft Database é o algoritmo de consenso Raft usado pelo Docker Swarm (o orquestrador de contêineres nativo do Docker) para gerenciar o estado global de um cluster de forma distribuída e tolerante a falhas.

### Não transforme gado em animais de estimação

- Assuma que nodes podem ser substituídos
- Assuma que containers podem ser recriados
- Se você somente criar os containers, colocá-los no swarm e não fizer mais nada e ir escalando sem se preocupar com os detalhes "fancy" como SSD ou HealthCheck, não será bom.
- Assim como vc colocar todas essas features no container mas não colocar no host também não é uma boa prática. Se vc fizer tudo isso remotamente e não armazenar essas coisas no HD, esse nó não vai ser especial como vc pretendia. Você pode sim fazer testes e troubleshooting no container, mas não se esqueça de tbm fazer no host.

---------------------------------------------------------------------------------------;

## Razões para múltiplos Swarms

### Razões RUINS

- Você pode fazer muitas coisas em um swarm único. Não há hardset limites.
- Diferentes configurações de Hardware (ou OSI)
- Diferentes subredes ou grupos de segurança
- Diferentes zonas de disponibilidade
- Limites de segurança para compliance

### Razões BOAS

- Aprendizado: Rodar testes de swarm = Dá ao team de DEVOPS a chance de errar antes de subir para produção
- Limites Geográficos
- Gerenciamento de Limites (boundaries) usando Docker API (ou docker EE RBAC ou outro plugin). Docker API é "tudo ou nada". Pesquisar o por quê.

---------------------------------------------------------------------------------------;

### E Swarm em Windows Server 2016?

- Vídeo no minuto 34. Esse conteúdo já se tornou obsoleto, entao pulei;
- Se quiser ver mais sobre esse tema: perguntei ao gemini sobre pq trazer esse tema num contexto de uma palestra em 2017

---------------------------------------------------------------------------------------;

### Terceirizar Plumbing bem definidos

- Talvez você não precise fazer tudo "in house", talvez você não precise inovar em tudo;
- Evite a síndrome de "não está implementado aqui"
- Outsource pode ser tipo um SAS ou simplesmente algum produto comercial

- O que você pode terceirizar? (outsource)
  - Registro de Imagens
  - Logs
  - Monitoramento e alertas

  - Você não precisa usar todas as ferramentas open source porque tipicamente com opensource, embora seja fantástico, você está quase sempre trocando produtos grátis por conveniência.
  - Usar ferramentas renomadas para as funcionalidades acima vai te economizar bastante tempo no desenvolvimento do seu projeto.
  - Para ver exemplos de ferramentas: <https://raw.githubusercontent.com/cncf/landscape2/refs/heads/main/docs/screenshots/landscape1.png>

### Tech Stacks

- Designs para um cluster com funcionalidades completas

  - HW / OS (hardware e sistema operacional) = Infrakit e Terraform. Servem para deployar sua infra,
  - RUN Time = Docker
  - Orquestração = Docker Swarm
  - Networking = Docker Swarm
  - Storage = REX-Ray, um projeto open source aodne você compartilha armazenamento com seus hosts
  - CI/CD = Jenkins
  - Registro = Docker Distribution + Portus. Não entendi se é uma alternativa ao dockerhub, procurar depois.
  - Layer 7 Proxy = Flow Proxy Traefik (NGINX).  Se vc trabalhar com web, vai precisar compartilhar a porta 8443 entre muitos containers, o que significa ter proxy reverso ou layer 7 proxy (mesma coisa)
  - Central Logging = ELK
  - Central Monitoring = Prometheus + Grafana. Prometeus controla o monitoramento, enquanto grafana fica mais responsável por gráficos.
  - Swarm GUI = Portainer.

  EXTRA
  - Function As a Service = OpenFaas

NOTA: O Portus é um serviço de autorização de código aberto e uma interface web (front-end) para o Docker Registry (API v2). Ele permite administrar, organizar e controlar o acesso a registros privados de imagens Docker instalados localmente (on-premises).

- E se usássemos alguns SAS Products??
- Docker for X: Tech Stacks fáceis e baratas

  - HW / OS (hardware e sistema operacional) = Docker for AWS/Azure
  - RUN Time = Docker
  - Orquestração = Docker Swarm
  - Networking = Docker Swarm
  - Storage = Docker for AWS/Azure
  - CI/CD = CodeShip TravisCI
  - Registro = Docker Hub e Quay
  - Layer 7 Proxy = Flow Proxy Traefik (NGINX).
  - Central Logging = Docker for AWS/Azure
  - Central Monitoring = Librato e Sysdig.
  - Swarm GUI = Portainer.

- Os que mudarão são uma sugestão de como melhor rodar os seus swarms nesses clouds e acelerar seu desenvolvimento, solucionando problemas que se fosse de outro jeito vc resolveria sozinho. Pra melhorar, 

- Docker Enterprise Edtion + Docker for X

  - HW / OS (hardware e sistema operacional) = Docker for AWS/Azure
  - RUN Time = Docker
  - Orquestração = Docker Swarm
  - Networking = Docker Swarm
  - Storage = Docker for AWS/Azure
  - CI/CD = CodeShip TravisCI
  - Registro = Docker EE (DTR)
  - Layer 7 Proxy = Docker EE (UCP)
  - Central Logging = Docker for AWS/Azure
  - Central Monitoring = Librato e Sysdig.
  - Swarm GUI = Docker EE (UCP)

Isso é o que mudaria. Docker para AWS é de graça. Obviamente vc paga pela infra, mas os templates são de graça. Da forma acima dá pra perceber que está bem dockerizado (usando ferramentas próprias do docker). É a forma mais rápida para deployar.

As stacks acima também oferecem Image security scanning, RBAC, Image Promotion e Content trust.

---------------------------------------------------------------------------------------;

## Devemos ter um Orquestrador?

- Vamos acelerar sua migração docker ainda mais
- Já tem boa automação de infraestrutura?
- Talvez você tenha uma boa VM Autoscale? (De escalar)
- Gosta dos limites de segurança dos VM OS?

- UM container por VM

  - Apesar de não ser mais falado na indústria, funciona completamente.
  - Menos mudança de infra. Além disso:

    - Melhora suas habilidades para escrever Dockerfiles;
    - Aprende como lidar com docker em produção
    - Obviamente vc não vai escalar isso, não vai ter vários container em uma VM só

  - Windows está fazendo isso com Hyper-V
  - Linux está fazendo isso com Intel Clear Containers
  - Linuxkit vai deixar mais fácil: Immutable OS
  - Atenção com LCOW (Linux containers on windows) usando Linuxkit

---------------------------------------------------------------------------------------;

## Resumo

- Remova requisitos opcionais a princípio.
- Primeiro foque no Dockerfile/docker-compose.yml
- Atenção com antipadrões no Dockerfile
- Prefira OS e imagens FROM familiares
- Cresça o seu Swarm conforme você cresca e precise no seu projeto.
- Ache formas de terceirizar o "plumbing
- Perceba que suas tech stacks podem mudar, se mantenha flexível

- Sua primeira escolha pode não ser sua melhor escolha. OK. Não tem problema.

---------------------------------------------------------------------------------------;

DOCKER SWARM EM 2020 = A TENDÊNCIA É ACABAR
<https://www.youtube.com/watch?v=L5N43aQQArw&t=223s>

Tudo que vc achava que sabia sobre orquestração - mesmo evento da palestra
<https://www.youtube.com/watch?v=Qsv-q8WbIZY>
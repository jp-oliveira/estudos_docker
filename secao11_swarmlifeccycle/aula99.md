>Service Updates

A funcionalidade de update do swarm é centrada em um padrão de update contínuo para as réplicas. Ou seja, fornece substituição contínua de tarefas / containers em um serviço. Se seu serviço tem réplicas, o update levará essas mudanças para todas as réplicas, uma de cada vez.

Limita o "downtime" (cuidado ao afirmar que "previne" o downtime). Previnir downtime na verdade é o trabalho do teste. Muito se fala que um orchestrator previne o downtime, o que o professor diz que não procede.

A depender do que esteja sendo atualizado, obviamente pode ser mais desafiador ou nao. Se for um site estático ou algum app que não demande conexão constante, será um update menos custoso. Do contrário, vai ser bem desafiador. Imagine por exemplo atualizar uma base de dados. Provavelmente vai impactar na aplicação web.

Cada aplicação que vc tem um serviço vai atualizar e impactar as outras coisas em volta dela diferentemente.

E na verdade isso não é o trabalho de um orquestrador. Um orquestrador não pode determinar se tal aplicação é um protocolo de database e um outro é uma app de protocolo REST, o que é fácil.

Portanto, nesse caso de atualizar serviços, se é somente uma API REST ou um frontend que não está fazendo nada complexo como web socket ou uma enquete, se é algo mto simples como um site estático, provavelmente o update será simples, sem maiores problemas. Como já falado acima. Databases ou persistência de dados, serviços que demandam uma conexão constante, vão ter um update mais complexo. Portanto, test earlier and test often.

Service Updates vai substituir containers para a maioria das mudanças. A menos que esteja mudando um label ou algum metadado com o serviço, o update vai mudar cada container com um totalmente novo.

Tem muitas opções no CLI. A maioria das opções são comandos CREATE com um -rm e um -a no final. Se as opções podem ser usadas para múltiplos valores (port por exemplo), então pode ser usada com -rm e -a. rollback e checasaude (health check) também podem ser incluídas.

Perceberemos que scale e rollback tem seus próprios comandos agora, ex:
>docker service scale web=4
>docker service rollback web

Se estiver lidando com stacks, um deploy de uma stack para a mesma stack é uma atualização. Na verdade, não há opção separada para atualizações de stack. Só faça stack deploy com o mesmo arquivo que está sendo editado. Então, vai funcionar com os comandos de serviço e network e todas as outras coisas que usem.

EXS:
1 - Atualizar a imagem usada para uma mais nova
> docker service update --image minha_imagem:1.2.1 service_name

O caso acima é por exemplo ir de uma imagem 1.2.0 para uma 1.2.1

2 - Adicionar uma variável de ambiente e remover uma porta:
> docker service update --env-add NODE_ENV=production --publish-rm 8080
Se quisesse remover uma variável de ambiente ou adicionar uma porta, o raciocínio seria o mesmo (com add e rm)

3 - Mudar número de réplicas de 2 serviços.
> docker service scale web=8 api=6

Novamente, em atualizações swarm, não há um comando deploy diferente. É o mesmo docker stack deploy, com o arquivo editado e o trabalho é lidar com todas as outras partes da API para determinar se alguma mudança é necessária e então aplica-las com um service update.
> docker stack deploy -c file.yml stackname

Teste no ubuntu:
> docker service create -p 8088:80 --name web nginx:1.13.7

Agora para mudar a quantidade de replicas:
>docker service scale web =4
Repare que ele só vai criar mais 3, o primeiro não vai ser alterado.

Agora para atualizar a imagem:
> docker service update --image nginx:1.13.8 web
Repare que ele vai atualizar uma de cada vez.

Repare também que, ao fazer docker service ps web, ele mostrará também o que exisita e não existe mais.

E PARA ATUALIZAR ALGUMA PORTA?
precisa remover e adicionar a porta ao mesmo tempo.
> docker service update --publish-rm 8088 --publish-add 9090:80 web
Repare novamente que ele vai atualizar uma de cada vez.

Repare porém que se fizer tanto localhost:9090 como localhost:8088 os serviços estarão respondendo em ambas as portas.

DICA:
Quando se atualiza algo significativamente "grande" como número de replicas ou uma imagem, temos que nos atentar porque o swarm NÃO atualiza os recursos automaticamente.
Precisamos fazer um:
> docker service update --force web
vai substituir as tasks e redistribuir, como estava antigamente. É o chamado rebalancing. Vai deixar tudo pareado, redirecionando recursos e containers.
> Routing Mesh

Routing Mesh é uma rede de entrada (incoming) que distribui pacotes para os serviços e às tarefas para esse serviço, pq podemos ter mais de uma tarefa.

Isso abrange todos os nós. Está usando kernel primitives chamados IPVS. São funcionalidades básicas do linux, nada muito fora do comum.

O que está ocorrendo é basicamente um Load Balancing entre todos os nós, entre os serviços swarms e suas tarefas.

Isso funciona de 2 formas:
    1 - Container para container em uma rede overlay - Se um frontend por exemplo falar com um backend que tem 3 réplicas, ele falará na verdade com um Virtual IP (VIP), que o swarm coloca na frente dos serviços.

        Esse ip é privado dentro da rede virtual do swarm, e assegura que a carga está distribuída entre todas as tasks do serviço. Portanto, não é preciso configurar um load balancer pra isso, pois o swarm já faz.
    
    2 - Tráfego externo chegando nas portas publicadas. todos os nós escutam. O swarm na verdade pode escolher em qual dos nós vai chegar essa comunicação.

        Qualquer um dos nós workers vai ter a porta publicada e escutar o tráfego do container, e então o tráfego será redirecionado ao container adequado baseado no load balancing.

Isso significa que ao fazer deploy de um container no swarm você NÃO deve se preocupar qual servidor vai agir e qual está on. Se um container cai e a tarefa é recriada pelo swarm, ele pode botar em um nó diferente. Nem precisa se preocupar com firewall ou DNS.

Portanto, ao colocar o drupal na porta 80, o swarm já fez o trabalho de deixá-lo acessível de qualquer nó do swarm. Em background, o swarm está redirecionando os pacotes do servidor para aquele container escolhido. Se estiver no mesmo nó ou não, será redirecionado de qualquer forma. E isso não precisa ser setado, já é assim por default.

Para entender melhor, veja o exemplo nesse vídeo aula. NÃO CONFUNDIR COM DNS Round Robin. OS benefícos do VIP que o round robin não tem é que em muitas vezes os caches do dns dentro do nosso app evitam que distribuamos a carga. Ao invés de lutar com nossos clientes DNS na configuração DNS, nós só estamos "baseando(relying)" no VIP, o que é exatamente oque faríamos se fizessemos o balanceamento de cargas manualmente.

Ex do load balancing atuando:

> docker service create --name search --replicas 3 -p 9200:9200 elasticsearch:2

contextualizando: elasticsearch é uma db de procura acessível por um JSON web

Espere algum tempo e faça:
>docker service ps search
e veja os serviços lá. 

Se fizermos
> curl localhost:9200
várias vezes, veremos que um ciclo de 3 nomes se repete, obviamente em ordens diversas. Isso comprova que o load balancing está atuando, pois o localhost:9200 está atingindo ips diferentes.

Resumindo:
-> Routing Mesh é um load balancing STATELESS. O que isso quer dizer? que se vc tiver que usar session cookies na aplicação ou espera um container robusto e consistente para se comunicar com um cliente consistente, provavelmente vai ter que adicionar outras coisas para esse caso.
Ou seja, da forma como está hoje, toda vez que  lidarmos com um serviço com múltiplas tarefas, provavelmente teremos resultados DIFERENTES.

-> Esse load balancer está na camada 3 do modelo OSI (TCP) e não na camada 4 (DNS). Isso interfere no lidar com múltiplos sites na mesma porta no mesmo swarm, mas é mto mais teoria do que outra coisa.

-> Essas limitações podem ser superadas com:

- Nginx ou HAProxy LB proxy, que podem atuar como uma camada a frente do routing mesh, atuando como um stateful load balancer, podendo também fazer outras coisas como cache e várias outras coisas.

- Docker Enterprise Edition, mas é uma saída paga. Vem com um webproxy na camada 4. Se quiser, ler mais sobre.
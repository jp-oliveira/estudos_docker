**Principais Comandos de Docker Network**

*Mostrar as redes existentes*
> docker network ls

Bridge é a rede padrão do docker, que está com um NAT atrás do ip do host.
Faz uma ponte pelo firewall NAT para a rede que o host está conectado

*Inspecionar uma rede e dar os principais detalhes*:
> docker network inspect NOME_DA_REDE

Mostra inclusive os containers que estão conectados a essa rede.

É bom reparar, pelo IPAM, que as redes recebem um ip e um gateway padrão; Esse ip pode mudar. Mudando, o gateway para essa rede vai ser direcionado para fora da rede.

Existe também a rede "host". É uma rede especial que bypassa a rede virtual do docker e anexa diretamente o container a interface do host. Há prós e contras, porque previne as fronteiras de segurança da containerização de proteger a interface do container.
Por outro lado, em algumas situações, pode melhorar a performance da rede e se deparar com outras questões específicas.

Por fim, a rede "none", que é equivalente a ter uma interface na sua máquina que não está anexada a nada, mas nós podemos criar a nossa própria. Remove eth0 e só te deixa com a interface local no container.

*Criar uma rede*
> docker network create --driver

Esse comando opcional driver pode ser usado para usar built-in e drivers de fora para criar uma nova rede.

Ao criar, repare que o driver padrão é o bridge. É um driver único que simplesmente cria uma rede virtual localmente com sua própria subrede em algum lugar com o ip 172.17 ou acima, pq vai incrementando 17, 18, 19 e assim por diante.

Agora, ao criar um container, podemos anexá-lo a uma rede específica com o argumento --network NOME_DA_REDE

*Anexar uma rede a um container*
> docker network connect REDE CONTAINER_QUE_QUERO_CONECTAR

Mas atenção: você anexar um container a uma rede NÃO tira ele da outra. Ele fica conectado a duas redes ao mesmo tempo.

*Desanexar uma rede de um container*
> docker network disconnect REDE CONTAINER_QUE_QUERO_DESCONECTAR

Os comandos de connect e disconnect são usados, como dito, para mudar a rede. AO mudar, um novo NIC(Network Interface Card) é criado em uma rede privada para esse container. É tipo adesivar um cartão no computador enquanto ele estiver  rodando.

Se quiser ver mais vantagens e desvantagens de separar os ambientes de frontend e backend no mesmo servidor, ver os 40 segundos finais do vídeo.
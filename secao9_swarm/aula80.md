> Quanto mais containers juntos, mais problemas

- Como automatizar o ciclo de vida dos containers?
- Como escalar os containers? (tanto para cima quanto para baixo)
- Como assegurar que os containers serão recriados se falharem?
- Como substituir os containers quando houver uma atualização para eles sem cair? (blue/green deploy)
- Como criar redes virtuais entre os nós? (supondo uma situação aonde subamos vários nós com containers diferentes)
- Como assegurar que somente servidores confiáveis estão rodando os containers?
- Como armazenar dados secretos como senhas, chaves e outras infos que normalmente se deixam no env?

Para essas e outras perguntas existe o swarm. Swarm é basicamente uma solução para clusters de servidores. Faz com que todos os servidores sejam uma unidade gerenciável aonde é possível orquestar os ciclos de vida dos containers.

Não vem ativado por padrão, precisa ser ativado. Por isso não afeta tudo que já foi criado.

Se quiser ver detalhes técnicos da comunicação entre os containers, veja a aula (control plane, TLS, Managers e Workers)

Os Manager Nodes tem bases de dados locais - Raft Database. Os Manager Nodes armazenam a configuração e dão aos nós a informação necessária para ser a autoridade dentro de um swarm. Pode haver mais de um manager.

Cada Worker e Manager seria uma máquina virtual ou um host físico rodando alguma distribuição do linux ou windows server. Eles se comunicam, como pode ser visto no control plane. Esse control plane mostra como as ordens são enviadas e trocadas por um swarm.

Os managers enviam ordens para os workers. Um worker pode mudar de função e ser um manager e vice versa. Portanto, um manager é um worker com permissão para controlar o swarm. Para se comunicarem, basta estarem rodando o mesmo docker.

Os comandos de Swarm substituem os comandos normais de docker, adicionando novas funcionalidades, como por exemplo réplicas, para informar quantos containers queremos rodar (vem atuar na questão de escalabilidade - aumentar e diminuir o número de containers). Essas réplicas vão se chamar tarefas (tasks).

Um simples serviço pode ter múltiplas tasks e cada task pode rodar um container.
No exemplo do vídeo, é um serviço com 3 réplicas, 3 tasks.
Novos comandos entram em cena. Para melhor entendimento, ver o final do vídeo:
_______________
               |
API           R|
Orchestrator  A|
Allocator     F| Manager Node
Scheduler     T|
Scheduler     T|                               _________
Dispatcher     |  <----------------------------|Worker  |
______________ |                               |Executor|    Worker Node
                                               ----------
## Registros

Um registro de imagem precisa ser parte do seu plano de container. Não é opcional. O docker foi desenvolvido para ter um lugar, fora dos servidores e fora das estações de trabalho dos devs, para ARMAZENAR as imagens.

Poderiam ser simplesmente um arquivo que pudesse ser zipado e deszipado, mas há formas melhores de fazer isso.

Falaremos sobre mais funcionalidades do docker Hub, incluindo o autobuild.

Falaremos mais a frente sobre Docker Store e Docker Cloud. Docker Cloud pode tornar mais fácil a tarefa de fazer deploy servidores e outras coisas suas em nuvem.

Nova funcionalidade do swarm no cloud para conectar mac e windows ao swarm.

Aprenderemos a instalar, registrar e deployar tanto na máquina local ou em um docker swarm para usar como um registro privado. é open source.

Também falaremos sobre opções de terceiro para registro.

Falaremos também sobre linkar o github ao dockerhub e checaremos ferramentas de autobuild para autobuildar imagens baseado nos commits.

Buildando junto uma "cadeia" de imagens, para assegurar que sempre estarão atualizadas.

## Docker hub
O mais popular registro público de imagem.
É onde nós "puxamos" nossas imagens, é o registro oficial do docker, apesar de não ser o único.

**SETTINGS**

Para contas free no dockerhub, só pode haver um repositório privado.

## Webhooks
São úteis quando as imagens estão buildadas e "empurradas" para o dockerhub.
É possível ter a imagem enviando um webhook para algum outro serviço como Jenkins, Codeship, Travis CI, etc para ter builds automáticos continuamente.
Portanto, webhooks existem para ajudar a automatixar o processos de pegar os códigos por exemplo do git/github para o docker e também para os servidores aonde vc quiser roda-los.

## Collaborators
Dar permissão a alguém que pode pushar e pullar do/para esse repositório.

**Organizations**
Como se fosse um grupo de usuários, similar ao que tem no windows e no SISCSI. Mais fácil para dar permissão para vários usuários.

Quando for fazer um push, crie primeiro o repositório pelo dockerhub.

**Create AutoBuild**
    - diferente nas versões atuais do dockerhub, verificar como fazer
    - É o inverso do webhook. Enquanto no webhook o dockerhub notifica alguém que o githb no docker está terminado, no autobuild o próprio dockerhub é notificado quando o github termina alguma ação. Pesquisar como fazer isso atualmente.

    Ver o vídeo no minuto 6/7 para entender melhor. Para configurar branches específicas no github por exemplo.

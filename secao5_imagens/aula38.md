docker history IMAGEM:TAG

O comando docker history mostra as camadas de mudança feitas na imagem. Um histórico.

Alguns dos layers podem ter size 0, justamente pq podem ser mudanças somente de metadados.

As mudanças e as datas que elas ocorreram cvêm lá do docker hub.

Obviamente, se eu faço com imagens diferentes, a listagem será completamente diferente.

Cada layer tem um SHA único (Security hash Algorithm). Isso é importante pq? imagine que eu tenho uma imagem.

IMG1 
\/
----------
change1
----------
IMG1_COM_CHANGE1
----------
change2
----------
IMG1_COM_CHANGE1_E_COM_CHANGE2
----------
.......

Há um sistema parecido com o que ocorre com o git. Conforme eu vou, com os dockerfiles, adicionando mudanças na minha imagem, vou acrescentando camadas. Como cada camada tem um hash único, não corro o risco de armazenar as mesmas informações.

Isso poupa armazenamento e tempo de transferêcia nos comandos push e pull para imagens.

Inclusive, por meio da tag, posso também acrescentar mudanças diferentes. Por exemplo, depois da change1 eu posso criar outra img com uma change3 e não uma change2 por exemplo.

Esse é o conceito de CACHE da imagem.

> docker inspect

Nos dá todos os detalhes sobre a imagem. Informa os metadados.
Informação de portas, de onde expor, de onde essa imagem espera rodar, variáveis de ambiente. Tbm tem autor das mudanças, arquitetura amd64, tudo.


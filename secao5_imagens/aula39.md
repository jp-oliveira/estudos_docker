> Tags

Imagens não tem necessariamente um nome.

ao fazer docker image ls, note que há uma coluna repository. Imagens oficiais não tem escrito usuario/repository (usuario ou nome da organização). Já as não oficiais tem. O mesmo conceito se aplica quando for pesquisar imagem no dockerhub.

A tag nada mais é do que um ponteiro para um commit específico da imagem, no caso uma versão.

Pegando o caso do nginx: se eu faço pull para duas tags que apontam para a mesma versão, no docker image ls eu vou ter ambas listadas, porém, como já falado antes, não vão ocupar 2 espaços, devido ao cache. Vão ter também o mesmo id.

imagem:latest é uma convenção de ser a última versão estável, mas não necessariamente é, pois é só o nome da tag.

E SE EU QUISER DAR UMA NOVA TAG PARA UMA IMAGEM QUE EU JÁ POSSUO??
Posso fazer assim:
docker image tag IMAGEM_JA_EXISTENTE novatag

exemplo:

docker image tag nginx manocarsystem/nginx

Dará certo e ainda não subirá para os meus repositórios. Só subirá quando eu fizer:
docker image push manocarsystem/nginx

Porém pode ser necessário fazer login com docker login -u manocarsystem ou simplesmente com docker login.

Se você não confiar na máquina que você está trabalhando, é bom fazer docker logout também. 
cat .docker/config.json está diferente agora do que o mostrado no vídeo, ver se com o passar do tempo as coisas mudaram.

Outra forma de botar tag:

docker image tag manocarsystem/nginx manocarsystem/nginx:testando

Por fim: se quiser criar uma imagem privada, crie o repositório primeiro no docker hub.
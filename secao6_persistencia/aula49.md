> Bind Mount (Montagem de Vínculo)

É  um mapeamento de arquivos/diretórios do hosts para um arquivo/diretório do container
Basicamente é ter 2 caminhos apontando para o mesmo caminho físico no disco.

if there are any files in the container that you map the host files to, the host files win. Portanto não deleta de verdade os arquivos no container que foram sobreescritos porque no container na verdade não sobreescreve nada, lá é somente aonde existe a montagem de vínculo.

A partir do momento que você não precisar mais do bind mount e rodar o container sem ele, vc verá os dados que tinham lá antes, até porque são referentes ao host, não ao container.

IMPORTANE: não pode ter no Dockerfile, mas sim no comando run. como?

-v //c/Users/User/ESTUDOS_2026_UM_NOVO_DEV:/path/container ( no mac, troca // por /)

Fiz cd udemy-docker-mastery e estou dentro de dockerfile-sample-2 para ter ao acesso ao dockerfile. Dentro dele eu rodei:
docker container run -d --name nginx1 -p 80:80 -v $(pwd):/usr/share/nginx/html nginx  

primeiro: para saber o caminho a usar no volume, inspecionar a imagem para saber. Se não tiver, procurar no Dockerhub e na imagem oficial, lá ele informará.
segundo: esse $(pwd) é usado para se referir ao caminho atual em que estamos.

O que esse comando fez: como na pasta tem um Dockerfile, ele rodou uma "stock image". Para confirmar, basta rodar em outra porta e sem -v:
docker container run -d --name nginx2 -p 8080:80 nginx

Verá que os dois têm index.html diferentes.

Ainda no nginx1:
para ver as mudanças acontecendo, faça um pequeno teste:
touch teste.txt
echo "veja as mudanças acontecendo" > teste.txt
e agora faça localhost/teste.txt

Verá o testo inserido lá.
Para ver o mesmo path porém dentro do container:

abra um outro cmd
faça docker container exec -it nginx1 bash
faça cd /usr/share/nginx/html (é o caminho onde fica o volume dessa imagem)
faça ls (se quiser bote -al)
Veja que o arquivo teste estará lá. Ou seja, ele está tanto "dentro do container" como na pasta dockerfile-sample-2.
Se eu excluo o arquivo de dentro do container, também excluirá do host.

Resumindo: 
O bind mount permite associar um diretório existente no host a um diretório dentro de um container.

DICA PARA PRÓXIMA AULA:
ao usar postgres, usar a variável de ambiente POSTGRES_PASSWORD=minhasenha ou diga para ignorar a senha com POSTGRES_HOST_AUTH_METHOD=trust

Para aula 52:
old = postgres:15.1
new = postgres:15.2
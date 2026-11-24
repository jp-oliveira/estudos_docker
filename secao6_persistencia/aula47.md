>Volumes

Quando se trata de volumes, no Dockerfile tem uma tag VOLUME para indicar aonde será armazenado. Ex:
https://github.com/docker-library/mysql/blob/7f30fdb0738041fc5125e8218e393e0a891243e9/9.7/Dockerfile.oracle
Aqui é onde o mysql salva os dados.

VOLUME /var/lib/mysql
Essa localização é a localização padrão das MYSQL Databases. Essa tag quer dizer que essa imagem está programada de uma forma que diga ao docker para criar um NOVO volume nesse caminho e associarmos ao container quando iniciarmos um novo container.
QUALQUER ARQUIVO que nós colocarmos nesse caminho vai persistir até deletarmos manualmente o volume.

Adendo: volumes, a princípio, só podem ser deletados MANUALMENTE.
Adendo2: podemos fazer docker volume prune também, somente para limpar volumes não usados.

Ao fazer docker inspect IMAGEM_NOME, verá que há, no json, um campo volumes. É lá que tudo será salvo.

docker container run -d --name mysql1 -env MYSQL_ALLOW_EMPTY_PASSWORD=True mysql
docker container inspect mysql1

Veremos que, em volume do inspect do container e o volume do inspect da imagem têm o mesmo path.
Em Mounts, ao inspecionar o container, veremos o location único próprio no host, para armazenar dados e tbm em background, mapeado ou "montado" para o location no container. 
Em Source, veremos o caminho real. em destination, veremos o caminho que o container pensa que está escrevendo.

docker volume ls
docker volume inspect ID_DO_VOLUME

Há um campo chamado Mountpoint, que, POR ENQUANTO, vamos assumir que ele só é acessível se estivermos em um linux. No windows e mac, há uma linux vm rodando, então o volume na verdade estará lá.

Agora, tenho apenas um container com volume. Rodemos o segundo.
docker container run -d --name mysql2 -env MYSQL_ALLOW_EMPTY_PASSWORD=True mysql

Se fizermos docker volume ls, veremos 2 volumes diferentes. Até aqui ok.
Se pararmos os containers e removermos, os volumes ainda assim existirão. O que confirma a persistência de dados.

E COMO NOMEAR OS VOLUMES?

ao rodar os containers, inserir a clausula -v.

docker container run -d --name mysql1 -env MYSQL_ALLOW_EMPTY_PASSWORD=True -v ALGUM_NOME:/var/lib/mysql mysql

o nome, como mostrado, vem antes dos dois pontos, vindo depois aonde ele está localizado. Um alias bem mais conveniente que uma sequência aleatória.

faça depois docker volume ls para ver o volume com o novo nome.
faça tbm docker volume inspect ALGUM_NOME para ver o novo campo "Name"

Faça tbm docker container inspect mysql2. O campo Mount também estará diferente, com um nome mais amigável.

Podemos SIM ter o mesmo volume para 2 containers diferentes.

existe docker volume create. faça --help e veja as tags. Mas veremos mais tarde.

Path expansion: no windows powershell usar ${pwd}, em cmd.exe "Command Prompt" use %cd%
ENTRYPOINT X CMD

Docker precisa de pelo menos um cmd ou um entrypoint para o container rodar. Podem rodar juntos, mas primeiro veremos como rodar um ou outro e suas diferenças.

Ex: imagem do busybox

docker pull busybox
docker inspect busybox

no json, veremos: "Cmd": ["sh"]

Isso quer dizer que toda vez que essa imagem rodar, rodará com o shell (sh). Portanto, rodemos com -it, que é a forma de rodar bash dentro do container.

O Cmd é SOBRESCRITO

comandos linux
whoami - nome da máquina
ls - lista as pastas
ps - lista os arquivos
ls /bin = lista todos os binarios dessa imagem; i.e, todos os programas instalados
hostname = autoexplicativo
date = autoexplicativo

----------------------------------------------------------------------------------------------
Ex: na imagem:

```dockerfile
FROM busybox:latest
ENTRYPOINT ["hostname"]
```

dentro do bash ubuntu fazer os cd adequados e fazer

```bash
docker build -t entryhostname .
```

ao rodar um container com essa imagem, o hostname será impresso (o id do container nesse caso)

```bash
docker run entryhostname
```

NÃO PODE SER COLOCADO NADA DEPOIS DO entryhostname, pq o entrypoint não pode ser sobrescrito (exceto com a tag --entrypoint)
-------------------------------------------------

Porém daria a MESMA COISA fazer

```dockerfile
FROM busybox:latest
CMD ["hostname"]
```

```bash
docker build -t hostnameimg .
```

```bash
docker run hostnameimg
```

A diferença SÓ SERIA PERCEBIDA se fizesse:
docker run hostnameimg date = imprimiria a data E NÃO IMPRIMIRIA O HOSTNAME, pois o comando hostname da imagem hostnameimg está sendo sobreescrito pelo comando date.

docker run entryhostname date: NÃO imprimiria a data, pois o ENTRYPOINT por si só NÃO admite que rode comandos APÓS a imagem. Daria hostname: sethostname: Operation not permitted

Vamos entender:
faça docker container run --help
docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
Obviamente, o que está em [] é opcional.

Sem ter CMD, é possível colocar comandos depois da imagem, pois o [COMMAND] SUBSTITUI  a tag CMD.

Só funcionaria com:
docker run --entrypoint date entryhostname

Porém é inútil ter um ENTRYPOINT se ele vai ser substituído.

----------------------------------------------------------------------------------------------
Revisão:
ENTRYPOINT e CMD executam um comando ao rodar o container.

ENTRYPOINT exige mais escrita para sobreescrever comparado ao CMD, então é raramente usada sozinha para substituir o cmd. Porém, brilha ao ser usado JUNTO com o cmd. Veremos depois. É um complemento ao cmd. Use o cmd por default.

Se a imagem vai rodar um longo proceso no background, como webserver ou db, o cmd é o ideal. Basta ver no dockerhub, a grande maioria das imagens tem CMD e não ENTRYPOINT

podemos REESCREVER o entrypoint ao rodar um container:

docker container run --entrypoint ALGUMA_COISA <image>
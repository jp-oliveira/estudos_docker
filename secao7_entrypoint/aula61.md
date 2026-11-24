**Usar cmd e Entrypoint ao mesmo tempo**

O que acontece se declarar os dois ao mesmo tempo?

o que o docker faz:
ENTRYPOINT [space] CMD

junta os dois em um único comando separado por espaço.

Possíveis usos:

CLI Tools - Como um command line. Quando o docker rodar o container, faz uma coisa e depois sai, normalmente gerando um texto  no CLI.
Startup Scripts - Roda Antes do programa começar de fato

ex: um dockerfile com um ubuntu para rodar um curl. A meta é deixar a imagem da forma mais parecida como se tivesse o curl já instalado, com o mínimo de escrita possível.

```dockerfile
FROM ubuntu:latest

RUN apt-get update && \
    # fazer update antes é padrão para instalação
    apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/* 
    # limpar a base de dados dos pacotes depois para não adicionar coisas desnecessárias a imagem

# MODO 1
CMD ["curl"]

#MODO 2
ENTRYPOINT ["curl"]

#MODO 3
ENTRYPOINT ["curl"]
CMD ["--help"]

```

Do modo 1, teria que rodar da forma abaixo para sobreescrever o cmd inteiro toda vez:

```bash
docker run bretfisher/curl curl google.com 
```

Do modo 2, teria que rodar:

```bash
docker run bretfisher/curl google.com 
```

Do modo 3:

 ```bash
docker run bretfisher/curl google.com 
```

Estamos fazendo curl google.com.
se esquecessemos de escrever a url ao rodar o container, o cmd não seria sobreescrito. então, o output seria o --help, pois o comando seria curl --help.

A Vantagem de juntar os dois é manter o comando pequeno porém com a flexibilidade de adicionar algumas opções no final ao rodar o container.

Outro exemplo:

```dockerfile
# add -Y for nice color output:

ENTRYPOINT ["httping", "-Y"]
CMD ["--version"]
```

```bash
docker run brethfisher/httping google.com
```

o  CMD só vai entrar em ação se não houver a 3 parte do comando acima (google.com )

----------------------------------------------------------

OUTRO CASO DE USO - CONTAINER STARTUP SCRIPT

startup.sh
echo "alguma coisa"

Eu poderia simplesmente fazer CMD ["./startup.sh"]. Até funcionaria, mas ocasionaria uma confusão, pois haveria um programa sendo subprograma do outro, os shutdown signals correriam o risco de não serem passados corretamente (SIGTERM, SIGINT), oque mataria os containers.. enfim, não daria certo. Se o container demorar 10s ou até 30s no kubernetes para ser derrubado, pode ser que o app não esteja exergando os shutdown signals. Portanto, NÃO É uma boa prática escrever comandos no CMD.

Solução para isso:

```dockerfile

FROM python:slim
USER www.data
WORKDIR /var/www/html
COPY requirements.txt .
RUN pip install --nocache-dir -r requirements
COPY . .
ENTRYPOINT ["./startup.sh"]
CMD ["python", "app.py "]
```

/\ desse jeito, o container vai startar assim:
./startup.sh python app.py

startup.sh

```bash
#! /bin/bash

# do some startupstuff
echo "Cheking permissions on /var/www/html"
mkdir -p /var/www/html/upload
chown -R www-data:www-data /var/www/html/upload

# Start de apliccation set in CMD
exec "$@"
```

Quando escrevemos $@, informamos para o shell que está rodando o script que pare de processar o script e substitua o seu próprio processo com o que quer que esteja escrito no comando depois do script. Basicamente, está mandando executar o que está no cmd, logo depois dele (SE O CONTAINER VAI STARTAR
./startup.sh python app.py), ele dá o aval para seguir executando python app.py. Imagens famosas fazem isso, como por exemplo a do mysql.

A imagem do mysql resumida é assim:

```dockerfile
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
```

Obviamente, no final do arquivo.sh tem um exec "$@". Como falado, a vantagem do exec $@ é poder SOBREESCREVER o que está no cmd em um outro comando. Exemplo:

Ex: Rode um container mysql assim:
docker container run --name myshell -it mysql sh

terá um shell aberto. Em outro cmd rode
docker top myshell

docker top container_nome = comando para listar os processos de um dado container.

Perceberemos, com o docker top que o único processo rodando é o sh. Isso prova que o CMD foi sobreescrito corretamente pelo sh e impediu o mysqld de rodar.

# 1 - The Docker Image

## Dockerfile

 Um arquivo Docker é a receita ou conjunto de instruções para fazer uma imagem de um container. Ex:

```docker
FROM python
RUN pip install flask
WORKDIR /app
COPY
CMD python app.py
```

Comentando cada linha (Pense também em cada linha como se fosse uma camada):
**FROM python** - Todo dockerfile precisa de um FROM. Podem ser FROM de vários locais diferentes. Ao fazer FROM python, a linha busca a imagem do python no DockerHub ou onde eu especificar. Isso inclui apenas python, seus binários e suas bibliotecas. **NÃO CONTÉM** drivers de host ou o kernel do linux ou qualquer outra coisa além do que o python precisa para ser executado.

**RUN pip install flask** - Adiciona uma nova camada, o flask.

Workdir é apenas  uma mudança de metadados, apenas muda o local no sistema de arquivos. 
COPY copia nosso código fonte do host em que estamos construindo em sua própria camda empilhada sobre as outras. 

Todos esses comandos juntos formam uma imagem usando o comando <i>docker build</i>

## Register

Toda imagem tem um hash que é o mesmo independente de qual máquina ele é lido.

docker push
docker pull

Container

docker engine

namespace = container. Recurso do linux que impede que o aplicativo em execução veja o restante do so.
Ele obtém seu próprio sistema de arquivos em branco e incluirá apenas os arquivos que estavam na imagem que buildar.

Terá seu próprio IP e seus próprios processos.

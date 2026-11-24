# Rodando um registro

Relembrando, um registro é somente um servidor HTTP. Por padrão ele roda na porta 5000.
O que faremos: iremos "reTAGear" uma imagem existente que baixamos do dockerhub e empurrá-la para nosso novo registro. Então, iremos removê-la do cache local e "puxaremos" do novo registro depois de "empurrá-la". Então, recrearemos o registro usando um "bind mount" e veremos como os dados foram armazenados.

O Docker por padrão não se comunica com registros sem HTTPS. Deve ter autenticação, certificado e tudo que o https provém. Chamamos isso de "Secure by Default".  EXCETO se for em localhost. Isso é positivo pq registro não vem com certificado por padrão, é necessário comprar.

Porém para registros "auto assinados" é possível habilitar a opção "insecure registry" na engine, o que não é recomendado, ainda mais se for em produção.

para começar:
> docker container run -d -p 5000:5000 --name registro registry

Perceba no docker container ls que está rodando. Se quiser acessar, veja que não mostra nada.

PORÉM SE QUISER IR VENDO OS REGISTROS DELE:
http://localhost:5000/v2/_catalog

Esse "/v2/_catalog" é o que vai mostrar os registros guardados localmente.

Devemos usar então tags. Lembra que para subir no dockerhub o formato correto é account_name/image_name?
Agora com registro devemos por um label do host.

**RODANDO em registry-sample-1**

```Dockerfile
docker pull hello-world
docker run hello-world
docker tag hello-world 127.0.0.1:5000/hello-world
```

Faça 
>docker image ls
e veja que há 2 imagens, uma com a tag e a outra sem.

Porém se fizermos agora:
> docker push 127.0.0.1:5000/hello-world
ele não mandará para o dockerhub, mas sim para o registro local.

Removamos agora as imagens.
> docker image remove hello-world
> docker image remove 127.0.0.1:5000/hello-world
Se não conseguir remover essa última imagem, mate o container registro primeiro.
se fizermos push 127.0.0.1:5000/hello-world ele virá. Show de bola.

Porém façamos agora com volume, que é o correto.
> docker container kill registro
> docker container rm registro

Diferença: O docker kill encerra à força a execução de um contêiner em funcionamento, enquanto o docker container rm apaga permanentemente o contêiner do disco. O docker kill faz o container ainda existir porém com o status Exited.

Rodando agora com volume:

> docker container run -d -p 5000:5000 --name registro -v  $(pwd)/registry-data:/var/lib/registry registry
> ll registry-data

Verá que não tem nada.

Porém se empurrarmos de novo com:
> docker push 127.0.0.1:5000/hello-world
veremos mudança no comando:
> ll registry-data

Dica de Comando "novo":
> tree registry-data
tree mostra diretórios e arquivos  visualmente. Nada útil para agora, para mais infos veja o vídeo.

Limpe os containers para o próximo vídeo.

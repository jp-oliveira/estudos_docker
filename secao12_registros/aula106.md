# Registry com Swarm

- Para trabalhar com registros em swarm, obviamente não usamos o comando docker run, mas sim docker service ou até mesmo uma stack file.

- Devido ao Routing Mesh, todos os nós tem permissão de ver 127.0.0.1:5000, como se fosse local. Acontecerá do mesmo jeito como um container, pq podemos dizer ao swarm para falar com ele mesmo para o registro.

- O swarm então vai usar o mesmo endereço 127.... Não teremos que habilitar o registro inseguro pq isso já é permitido pelo docker Engine. O routing mesh basicamente permite que todos os nodes falem com o registry como se fossem local

- Lembre-se de que, num contexto de produção, será necessário decidir como armazenar os dados. Qual diretório, como fazer, etc. Um registro é um container com persistência de dados.

Volte a ativar os nodes. O exemplo do vídeo mostra 5 nodes.

> docker node ls
> docker service create --name registry --publish 5000:5000 registry
> docker service ps registry

Agora façamos como na aula passada:
> docker pull hello-world
> docker tag hello-world 127.0.0.1:5000/hello-world
> docker push 127.0.0.1:5000/hello-world
Com o comando acima, estamos subindo para a nossa própria máquina. Veja mudando com o /v2/_catalog

Para apenas provar que esse vetor vai aumentando:

> docker pull nginx
> docker tag nginx 127.0.0.1:5000/nginx
> docker push 127.0.0.1:5000/nginx

Aumentou. Agora podemos usar essa imagem armazenada no nosso registro nos nosso serviços, ex:
> docker service create --name nginx -p 80:80 --replicas 3 --detach=false 127.0.0.1:5000/nginx

Observação: um serviço não pode rodar uma imagem que só existe em um nó. Um swarm tem que fazer pull e push em um registro que todos possam ver.  Porém como eu rodei registry como serviço, todos os nodes e manager podem ver. O que não aconteceria se eu tivesse rodado como container por exemplo.

Dica: para ver em qual nó cada réplica do nginx está rodando (e tbm assegurar que o nó retagado que está rodando, não o do docker hub):
> docker service ps nginx

anotação 03/11/2026 20:26
Não estão rodando varios nós. Voltar nas aulas passadas e ver certinho como rodar vários nós.

Portanto, obviamente todos os nós devem acessar as imagens. Vc deve se assegurar que as imagens usadas em um swarm são acessíveis independente do registro em que estejam. Isso é meio óbvio pois os nós não podem compartilhar imagens um com o outro.  Por isso a importância de usar registro. Eles DEVEM pullar e pushar de um registro.

Dica: se não puder rodar registros localmente, usa um bom online, um hosted SaaS (ver 8:30 do vídeo.)

Se estiver usando AWS ou outras ferramentas, prefira usar os registros onlines. Apenas use registros locais se houver alguma necesside offline ou restrições de segurança.

Quay.io is a popular choice, and is very comparable to Docker Hub as a cloud-based image registry.  Sysdig did a Docker Usage Report in April 2017 based off their users that shows Quay as the most popular cloud-based choice.

If you're on AWS, Azure, or Google Cloud, they all have their own registry options that are well integrated with their toolset.

If you want a self-hosted option, there's Docker EE, Quay Enterprise, and also GitLab, which comes with GitLab Container Registry, among others.


Pergunta
In order to run a container from an image from a different registry than Docker Hub, you would need to specify that registry in the settings of the Docker daemon.

Resposta:
False - We don't have to change any settings to do this, we just specify an image with our custom registry, like we did with the image in the lecture 127.0.0.1:5000/hello-world.
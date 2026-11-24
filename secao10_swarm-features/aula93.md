>Segredos: parte prática

Há 2 formas de criar segredos:

> docker secret create NOME_DO_SEGREDO arquivo
OU
> echo "alguma coooisa" | docker secret create NOME_DO_SEGREDO -
o traço no final manda ler do input padrão

>docker secret ls
> docker secret inspect NOME_DO_SEGREDO

Obviamente esse comando não mostra o conteúdo do segredo, não poderia ser tao fácil. Mostra quando foi criado, atualizado e outras infos.

E como consumir os segredos passando-os para um serviço?
ex:

```bash
docker service create --name psql && \
--secret psql_user --secret psql_pass && \
-e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass && \
-e POSTGRES_USER_FILE=/run/secrets/psql_user postgress
```

Para confirmar:
> docker service ps psql

pegue o nome do container e faça
> docker exec -it CONTAINER_NAME bash

beleza, entrou num bash dentro do container.
faça no bash:
> ls /run/secrets
verá lá os segredos.
se fizer
> cat /run/secrets/psql_user
verá o conteúdo.
>docker logs psql.blablabla
veja como o processo se deu

também é possível fazer
> docker service update --secret-rm
se fizer isso, o serviço seria recriado, ou pelo menos o docker iria tentar
ou
> docker service update --secret-add
para remover algum segredo, mas isso não faz sentido. Ignore por enquanto.

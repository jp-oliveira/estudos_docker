>secrets em stack

Para usar segredo com stacks, usar version 3.1 no mínimo.

Para usar segredos, basta seguir o que está em secrets-sample-2:

```yml
services:
  psql:
    image: postgres
    secrets:
      - psql_user
      - psql_password

secrets:
  psql_user:
    file: ./psql_user.txt
  psql_password:
    file: ./psql_password.txt
```

SE o segredo já estivesse précriado e fossemos menciona-lo, teríamos que fazer:

```yml
secrets:
  psql_user:
    external: true
  psql_password:
    external: true
```

Até tem formas mais longas de definir os segredos, especificando quem pode acessar, mas são coisas mais complexas.

SIM, é necessário declarar os segredos em cada serviço e também informar a lista de segredos, pq cada serviço pode ter seus próprios.

Sobe o stack da mesma forma:
> docker stack deploy -c docker-compose.yml mydb

uma vantagem dessa abordagem é que ao remover o serviço, seus segredos tbm são removidos.
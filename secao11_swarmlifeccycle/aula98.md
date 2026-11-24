## Ciclo de Vida completo do App

as vezes precisaremos de vários compose files e não necessariamente fazer um monte de coisa em um compose file somente. Seria um set de compose files:

1 - um docker-compose up para o ambiente de desenvolvimento local

2 - um docker-compose up config e um arquivo para um ambiente de CI e testes de integração

3 - em produção, usaremos esses arquivos para um docker stack deploy

No diretório swarm-stack-3 o que está acontecendo é o que chamamos de override.

Override - quando tenho o docker-compose file padrão e ele configura os default para os outros arquivos yaml.

Se houver um arquivo escrito exatamente dessa forma (docker-compose.override.yaml) vai trazer o que foi definido no docker-compose.

Repare que o override NÃO tem tag images pois ela já foi definida no docker-compose. No override ela virá sem precisar declarar. Além disso, o override é claramente para desenvolvimento local, pois tem a tag ports e build.

Repare que há um bind mount em .themes. É um indicativo que se quer montar o theme no host para o container como foi feito em seções anteriores. Isso possibilita, apenas para relembrar, que se possa mudar localmente o theme e refletir diretamente no servidor. Vantagem: não precisa parar e startar o container toda vez que houver uma mudança.

Lembre-se em segredos: se estamos codando localmente, o segredo DEVE ser file based e não com docker secret create...

Os arquivos .prod.yml e .test.yml não apresentam o mesmo comportamento do override (pegar as definições do docker-compose.yml)

-------------------------------------
para .test, teremos que subir com -f, o que indica que temos que especificar um docker-compose que vamos pegar.

veja que temos a volta da tag image. Não teremos que manter volumes porque é só uma plataforma de CI. Se algo der errado, vai se livrar de tudo.

Temos um bindmount para garantir que tenhamos a mesma amostra de dados cada vez que formos fazer um teste CI. Mais explicações, veja o vídeo no minuto 4:40.

------------------------------------
Para .prod, como não teremos linha de comando para docker compose, teremos um comando CONFIG no docker compose.

Teremos a volta da tag volumes em produção, bem como os segredos agora externos.

-----------------------------------
Portanto, se eu rodar docker-compose up no diretório swarm-stack-3, ele rodará o docker-compose.yml e o override.yml.

Para saber se está funcionando, basta inspecionar a imagem de drupal e ver os volumes. Se os volumes listados  estiverem lá, o override entrou em ação. Tbm teria outras formas de checar, mas essa é uma boa forma.

Para rodar em ambiente de teste:
> docker-compose up -f docker-compose.yml -f docker-compose.test.yml up -d

Novamente: para ver se subiu, uma maneira é inspecionar e ver que NÃO há volume, conforme esperado.

Por fim, para rodar em produção:
> docker-compose up -f docker-compose.yml -f docker-compose.prod.yml config

O config vai juntar os dois arquivos e formar um arquivo só.

O que poderíamos fazer tbm:
> docker-compose up -f docker-compose.yml -f docker-compose.prod.yml config > output.yml

Obs:

O comando extends é uma outra forma de fazer override porém ela NÃO funciona AINDA com stacks. Verifique se já mudou.

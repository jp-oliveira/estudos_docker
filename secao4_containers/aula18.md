lembre-se: se estiver usando docker toolbox, digite o ip 192.168.99.100


Image X Container

Image = os binários e bibliotecas e código fonte que a nossa aplicação é feita. É  a aplicação que queremos rodar.

Container = é uma instância da imagem que está rodando como um processo.

Podemos ter vários containers rodando a mesma imagem.

A imagem padrão do docker "registry" é chamada docker hub.

Todos pegamos as imagens de registros.
Registro são tipo o que o github é para código fonte e o que
Registros de imagens são para imagens de container e o default para docker é o dockerhub.

rode:
docker container run --publish 80:80 nginx

e depos acesse localhost. pronto, está feito.

posso atualizar a página várias vezes que no cmd estará lá o server escutando.

o que esse comando fez?

1 - Em background, o docker engine procurou por uma imgem chamada "nginx" e baixou a mais recente do dockerhub
2 - startou um novo processo em um novo container da imagem para ser usado.
3 - abriu a porta 80 no ip do host. a porta 80 da minha maquina local foi exposta e manda todo o tráfico dela para o executável rodando na porta 80

OBS: SE UM BIND ERROR SUBIR, SIGNIFICA QUE OUTRO PROGRAMA JÁ ESTÁ USANDO ESSA PORTA, TALVEZ ATÉ OUTRO CONTAINER. USE QUALQUER OUTRA PORTA QUE QUISER, COMO 8080:80 OU 8888:80. Então, digite localhost:8080 ou localhost:8888

docker container run --publish 80:80 --detach nginx

detach avisa o docker para rodar em background. Se vc ficar entrando nele e atualizar, não aparecerá os gets no cmd, ao contrário de antes.

docker container ls (antigo docker ps)
    lista os containers que estão rodando

docker container stop <id>
    esse id não precisa ser o id todo, apenas o suficiente para ser um id único.

docker container ls - a
    lista todos os containers, inclusive os que já foram parados. os nomes são aleatórios. A única regra é que devem ser únicos.

e para criar com nome??
    docker container run --publish 80:80 --detach --name meu_container nginx

já que está em background, como ver os logs desse container?
    docker container logs meu_container

docker container top meu_container
    vai mostrar o processo rodando dentro do proprio container

docker container rm COMEÇO_DE_ALGUM_ID COMEÇO_DE_OUTRO  #assim por diante
    Atenção: só é possível excluir container DEPOIS que vc para-lo.

exceto se vc fizer docker container rm -f algum_id

docker container ls -a
    rode esse para ver o efeito de ter excluído os containers selecionados

dokcer stop <NOME>
    para o container especificado.
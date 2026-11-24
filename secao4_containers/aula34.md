DNS Round Robin = Dois 

Como fazer com que dois endereços com ip's diferentes respondam a um mesmo ip?

tem a ver com load balancer. Ex: google.com não é somente um servidor com um único ip.

--network e --net dão no mesmo, assim como --network-alias e --net-alias dão no mesmo.

docker network create NOME_REDE NOME_DRIVER[opcional]

Se não especificar nome_driver, o bridge vai como default.

docker stop nome_container
docker rm nome_container

> sudo docker run -d --name es2_v2--network-alias primeiro_alias --net aula35 elasticsearch:2

Roda com a rede chamada aula35 e dá um alias pra ela de primeiro_alias.

> docker container run --rm --net aula35 alpine nslookup primeiro_alias

Assim que rodar o comando o container vai imprimir o resultado e vai só deixar de existir (importante frisar que tem que estar na mesma rede)

> sudo docker container run --rm --net aula35 centos:7 curl -s primeiro_alias:9200

Também vai deixar de existir e imprimir. É importante perceber que a cada vez que esse comando for gerado, no json impresso os "name" podem ser diferentes porém os hash vão ser sempre os mesmos.
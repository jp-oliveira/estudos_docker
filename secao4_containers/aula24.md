docker container ls é a mesma coisa que docker ps

| serve no linux como pipe: pegar o resultado do comando da esquerda e jogar no comando da direita.

grep serve para filtrar

cat serve para mostrar o conteúdo de um arquivo.

Não esquecer que pra deletar um container primeiro devemos:


docker container stop NOME OU ID DO CONTAINER

docker rm NOME OU ID
-----------------------------

docker container top
docker container inspect = retorna um json informando vários metadados do container
docker container stats = se não especificar container, retorna uma streaming view de dados de performance dos containers. Importante para monitorar armazenamento, uso de cpu, taxa de I/O

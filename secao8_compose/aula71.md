> mais infos de docker compose

Docker CLI

ideal para dev e teste.

Comandos para rodar na pasta que tiver o docker-compose.yml
docker compose up = configura volumes e redes e starta todos os containers
docker compose down = para todos os containers e remove cont/vol/net

Não esqueça do docker compose down, muitos esquecem.

No diretório compose-sample-2, temos em volumes um bindmount, que está fazendo um mapeamento.

O .conf, de acordo com o vídeo, é tipo um repositório git que armazena os arquivos de configuração. Permite mapear o arquivo para dentro do container.

o .ro no final indica que é read only

Nginx está atuando como proxy reverso e não como servidor web. É justamente isso que o .conf seta.

Além disso, ao startar esse compose, também criamos uma network própria. Ela é criada por padrão com esse nome, mesmo sem informarmos.

ATUALMENTE, ao fazer docker compose up ele te dá a opção antes de terminar se informar se faz as coisas em background ou foreground. Porém se quisesse podia fazer docker compose up -d.

Não esquecer do comando para ver o log:
docker compose logs

docker compose ps = ver os containers.
docker compose top = ver os serviços rodando dentro dos containers.

LEMBRA:
Se você adicionar um app e um db em um arquivo compose, especifique uma versão do app que vai ser compativel com a versão do db.

COMO FAZER PARA PASSAR UM ARQUIVO PARA O LINUX PELO TERMINAL UBUNTU:

criei um arquivo com o comando touch
copiei daqui (do windows, meu pc) e colei la com o editor nano, do ubuntu

Veja qual é o dbuser padrão do mysql direto na imagem dele no docker hub.
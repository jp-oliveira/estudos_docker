> Razões do Docker Compose

- Configurar relacionamentos entre containers
- Salvar as configurações do comando "docker container run" em um arquivo fácil de ler
- Criar ambientes de desenvolvimentos de startups (Scripts) em uma linha.

Divididos em 2 partes:

1 - YAML = linguagem de configuração que descreve uma configuração para:
    containers, redes e volumes, imagens e variáveis de ambiente.

2 - Uma ferramenta CLI usada para automação em ambientes de teste e desenvolvimento com os arquivos YAML

Também pode ser usado diretamente em produção com Docker Swarm (versão 1.13)

docker-compose --help

O nome padrão do arquivo é docker-compose.yml, mas é só uma convenção. Se for usar outro nome de arquivo, colocar -f no comando:
docker-compose -f

Olha o arquivo template.yml do compose-sample-1

Os arquivo YAML tem uma coisa estilo python. A formatação tem que ser com 2 ou 4 espaços. Tanto faz, desde que se mantenha constante.

-------------------------------------
version: de preferência a mais estável atualmente. google: 4.84

services: containers. As dicas estão como comentários no arquivo template.yaml

No docker-compose.yaml, tbm nessa mesma pasta, veremos no volume:

.:/site, aonde o "." equivale ao diretório atual que eu estou, semelhante ao ${pwd}

Repare que coisas que podem ter mais de uma ficam no plural, como volumes e ports.

e os itens ficam um em cada linha com um "-".

EXCETO em environment, vide o exemplo do compose-2. Pode OU NÃO ter o "-" na frente.

No compose-3, veja que há um name depends_on, que é basicamente: se o container2 tem no depends_on o container1 e o container0, o 0 e o 1 devem ser startados primeiro.

dica: docker-compose agora pode ser docker compose, sem o -.
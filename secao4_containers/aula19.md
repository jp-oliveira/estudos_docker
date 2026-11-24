**O que acontece quando digitamos docker container run?**

Muitas pessoas acham que o docker só gera os containers, porém o que acontece em background é:

1 - Busca pela imagem especificada no final do comando. No caso da aula passada, ele busca por nginx, especificado no final do comando. E busca aonde?
2 - Primeiro busca localmente no cache de imagens. se não encontrar, vai buscar no docker hub, que é o repositório padrão  remoto de imagens.
3 - Achando, faz o download e armazena no image cache. Se não especificar a versão, ele baixa a mais atual.

4 - Cria um novo container baseado nessa imagem. Ele não faz uma cópia da imagem, ele começa uma nova camada de mudanças, no topo.

5 - Customiza a rede - dá um ip virtual numa rede privada dentro do docker engine.

6 - Abre a porta que especificamos. Se não especificarmos nenhuma (no comando publish), ele abre a porta 80 do host e direciona todo o tráfego para a porta 80 no container.

7 - Inicia o container usando o cmd na imagem dockerfile

docker container run --publish 8080:80 --name webhost -d nginx:1.11 nginx -T

nginx1:11 - muda a versão da imagem
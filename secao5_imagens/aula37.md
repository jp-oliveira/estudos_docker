**DockerHub**

Se formor por exemplo no dockerhub e digitarmos nginx:

a imagem oficial do nginx vem com "official" escrito e sem um CONTA/nginx. As que vem assim geralmente foram imagens criadas por usuário.

Se criarmos na imagem principal do nginx, veremos várias tags:

ACESSO EM 23/06/2026 20:53 
digitar docker pull nginx:latest é a mesma coisa que :1.31.2 ou :1.31.  Se quiser instalar uma versão mais antiga, basta especificar o que chamamos de TAG, que vem depois do ":"

Para ver a qual versão a tag latest se refere, basta fazer a pesquisa no docker hub.

Atenção: se mesmo assim, forem instaladas as versões latest e 1.31 por exemplo, no docker image ls elas estarão lá. São a mesma imagem, basta olhar a imagem_id. Só o que muda é a tag. Mas são exatamente a mesma imagem.

Se você tentar instalar duas tags iguais, o docker irá perceber e pode inclusive perguntar se quer instalar a mais recente.
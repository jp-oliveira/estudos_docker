> dicas

comando prune

docker image prune -a

Remove todas as imagens que não têm pelo menos um container associado.

Não esquecer que, mesmo com EXPOSE no dockerfile, o container tem que rodar com o -p.

Não esquecer: o formato é PORTA_HOST:PORTA_CONTAINER.
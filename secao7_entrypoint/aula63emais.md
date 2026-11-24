>comandos para relembrar:

- Primeiro builda para gerar uma imagem simples, apenas para fazer um --help.
- Como buildar uma imagem (pesquisar nas aulas);
- Depois, adiciona o que falta no entrypoint e no cmd.
- builda de novo
- Relembrar como executar container com -it (pesquisar nas aulas).

na primeira imagem, para, com o dockefile correto, gerar o --help:

docker run -it --entrypoint sh cmatrix

--------------------------------------------------------------------
Aula 68

Num arquivo .sh:
-set e

Se no começo do script tiver isso, está informando para que o arquivo todo falhe caso algum comando falhe.

primeiro if do dockerfiles/entrypoint/assignment02:
    Se a pasta app/data existir, copia todos os arquivos de data-default para ela.
segundo if:
    As vezes, swarm e kubernetes criam segredos por arquivos e não por variáveis de ambiente. esse if está pegando do arquivo e trasformando em variável de ambiente.
terceiro if:
    faz o processo inverso desse segundo if. Pega o que tá em variáveis de ambiente e transforma em  arquivos config. Para saber mais, minuto 12.
quarto if(comentado):
    port na verdade sempre vai existir porque está no cmd, por isso foi comentado.

Por fim, o exec "$@" diz: passe esse script para o que quer que esteja depois desse comando (no caso, o que estiver no CMD).

Segundo e terceiros ifs são comuns em apps mais velhos. Ver mais no vídeo.

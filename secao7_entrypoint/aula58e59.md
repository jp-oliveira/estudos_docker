**Revisão de Dockerfile**

overwrite X additive
buildtime X runtime X both

Principais comandos em dockerfile:

FROM

ENV
    É um comando tanto buildtime quanto runtime. motivos explicados no copy para buildtime e no cmd para runtime.

    Não sobrescreve, é adicional. Ou seja, posso ter vários comandos ENV no mesmo dockerfile. No caso:
    ENV 80
    ENV 443
    é a mesma coisa que
    ENV 80 443

WORKDIR
    Também é overwrite, assim como o cmd. O último WORKDIR define o diretório aonde o cmd será executado.

COPY
    Comandos buildtime, ou seja, são aplicados no build. Tudo que acontece aqui é antes da imagem ser buildada, não influencia nada em em tempo de execução.
RUN
    Também buildtime.
EXPOSE

CMD
    Útil em tempo de execução, não no build. Ou seja, ele vai para os metadados da imagem para, ao rodar um container com essa imagem, o que estiver nele ser necessário para a imagem rodar no container corretamente. exemplo CMD ["python", "main.py"]

    É um comando overwrite. Ou seja, só o último cmd é válido, pois se forem escritos 2, o penúltimo é ignorado. LEMBRE-SE que as vezes o FROM já carrega um cmd próprio, o que significa que se um cmd for escrito para um from que implicitamente já tiver um cmd, o cmd irá sobreescrever o implícito do from.

ENTRYPOINT
    Como o cmd, também é overwrite e runtime.

para mais informações:
file:///C:/Users/User/Downloads/Dockerfile+Buildtime+vs+Runtime+Cheatsheet+2025-01.pdf
Para rodar uma imagem a partir de um docker file:

docker build -t nome_a_escolher localização_do_arquivo

ex:

docker build -t primeiro_build ./dockerfile-sample-1

Ao ir rodando, verá que cada linha no cmd gerará um hash no cmd, o que indicará que estará sendo guardado em cache. Se nada mudar, na próxima vez que buildar, essa linha não será reexecutada.

OBS: eu fiz docker build em um cmd diferente do linux padrão. Eu rodei num cmd do windows e consegui ver a img com docker image ls do próprio linux.

Para ver a nova imagem gerada, rode docker image ls.

Para comprar o que foi falado acima de não reexecutar e guardar no cache, experimente rodar o docker file depois de mudar somente uma linha. você verá que irá buildar muito mais rápido. Além disso, na linha irá aparecer: CACHED alguma coisa.

Portanto, uma sugestão: Se for copiar e colar, colocar na parte de BAIXO do código a parte com maiores mudanças. e na parte de cima o que tiver MENOS mudança, evitando retrabalhos.
> Usando compose para buildar imgens

- O comando docker compose também pode ser usado para buildar imagens customizadas.
- Vai buildar com o mesmo comando - docker compose up - se não achar a imagem em cache.
- Se a imagem já estiver em cache e você desejar rebuildar, use docker compose build ou docker compose --build
- Útil para build arguments. Falaremos depois, mas são tipo variáveis de ambiente disponiveis apenas durante o build.
- Repare no exemplo dentro de compose-sample-3:

se quiser buildar, tenha a tag build.
context é o caminho do arquivo da imagem que se quer buildar.
a tag image só é necessária caso vc queria dar um nome específico para a imagem.

ao rodar a imagem: como ela subiu com bind mounting, se vc mudar alguma coisa por exemplo no index.html vai aparecer automaticamente na tela, em localhost. Vantagem: alterar em tempo de execução.
ATENÇÃO PARA VER SE NÃO ESTÁ ATUALIZANDO DEVIDO AO CACHE.

para acessar index.html: cd html, nano index.html. Lá no arquivo mude alguma string.

Lembrando: pare o que subiu com o compose com docker compose down. Se quiser que as imagens criadas também sejam apagadas, veja com docker compose down --help

docker compose down --rmi local ou all, ver no help a diferença.
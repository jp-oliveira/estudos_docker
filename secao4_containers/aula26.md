Como rodar um shell dentro do container?

- Não precisa de SSH.

docker container run -it 

-i = interativo, mantém a sessão aberta para receber um terminal input
-t = pseudo-tty. Simula um terminal real, como SSH faz.

Depois do docker container run, existem alguns argumentos opcionais.

basta ver em docker container run --help

se eu rodar por exemplo:

docker container run -it --name proxy nginx bash

vai abrir o bash de dentro do proprio container criado.

vai abrir um root que NÃO se refere ao host, mas ao container.

nesse terminal posso fazer por exemplo ls -al para ver todas as pastas dentro do container baseado na imagem nginx.

além de ver os arquivos, posso de dentro desse terminal criar e editar arquivos, instalar novos pacotes, etc.

para sair desse cmd, basta rodar exit. Porem sair do cmd também faz o container parar de rodar. Basta ver a diferença com docker container ls e ls -a

Se eu rodar por exemplo docker container run -it --name ubuntu ubuntu

abrirei um container ubuntu com um terminal dentro. Posso fazer comandos dentro dele como apt-get update

A diferença entre uma vm com ubuntu e um container com a imagem ubuntu é que o container vem quase mínimo. Se quiser mais pacotes ou programas terá que instalar, como por exemplo o curl.

apt-get install -y curl

o comando curl tem várias funções, como pegar o código fonte de uma página, baixar um arquivo, salvar com um nome específico... enfim, é uma poderosa ferramenta de linha de comando usada para transferir dados de ou para um servidor. Ele suporta dezenas de protocolos (como HTTP, HTTPS, FTP e SCP), sendo ideal para baixar arquivos, testar APIs, inspecionar cabeçalhos de rede e automatizar scripts

para testar o funcionamento de um curl, basta fazer algo básico como curl https://www.pudim.com.br

**Para RESTARTAR um container com o bash mas ja com o bash aberto:**

docker container start -ai nome

**E se eu quiser , num container que já foi criado porém se o bash, abrir um cmd?**

Basta usar o comando EXEC. 

docker continer exec -it NAME bash

e o que é melhor - ao fazer exit no cmd, o container NÃO vai parar de rodar, pq ele não foi startado assim.

Alpine - uma distribuição do linux desenhada para ser muito pequena - 5Mb - par ver o tamanho, faça docker image ls e veja as diferenças entre os tamanhos. Alpine vem com seu próprio gerenciador de pacotes.
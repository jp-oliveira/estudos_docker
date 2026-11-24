> Extending official images

Geralmente não se extende imagens oficiais, o que se faz geralmente é, ao encontrar algum empecilho, ver se já foi feita alguma solução para esse problema.

Não há nada de errado em extender uma imagem oficial, só não se costuma fazer por ser mais trabalhoso.

sobre o dockerfile-sample-2:

WORKDIR
    Tem o mesmo efeito prático de RUN cd pasta 1 e RUN cd pasta 2. É mais prático, pois evita ficar entrando e saindo de diretórios.

COPY ARQUIVO_A_SUBSTITUIR ARQUIVO_A_SER_SUBSTITUIDO
    Esse comando está na verdade TROCANDO o index.html padrão do nginx pelo que está na pasta sample.

Nesse caso, não precisa do comando CMD pois de onde se está pegando o FROM já há um CMD explícito do próprio nginx.

bastaria fazer:

docker build -t NOME_DA_IMAGEM .  
Esse ponto é para caso ambos (dockerfile e index.html) estejam no mesmo diretório.

e depois rodar o container com essa imagem:

docker container run -p 80:80 --rm NOME_DA_IMAGEM

--rm é para remover o container depois que pausá-lo (ctrl + c)

Se atentar ao cache. Pode tbm buildar assim para evitar o cache:

docker build --no-cache -t nginx_mybuild .

para tagear de outra forma:

docker image tag NOME_DA_IMAGEM:latest usuario/NOME_DA_IMAGEM:latest

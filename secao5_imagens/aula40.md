>Dockerfiles

Toda vez que quiser lidar com um dockerfile, usar o comando -f, usado para especificar um arquivo diferente do default.
A ordem dos comandos importa, portando uma env declarada em determinada linha pode atender algum outro comando como pode também não atender.

Pegar os exemplos do sample1, nessa pasta.

FROM
    Exigido em qualquer dockerfile. Uma boa razão para usar  from debian, ubuntu, Fedora ou CentOS é porque essas imagens, além de já terem todas as seguranças necessárias por serem as oficiais, vem com os gerenciadores de pacote oficiais, como apt ou yum.

ENV
    Melhor forma de injetar chave/valor. Funcionam também para tudo que estiver escrito abaixo delas.

RUN
    Vai ter acesso, obviamente, a todos os comandos e binários especificados no FROM, respeitando a versão especificada. Ainda naquela questão de camadas, os && em cada linha certificam que todos os comandos rodam na mesma camada. Para ter acesso às variáveis ambiente no run, é da mesma forma que js/ts, com ${NOME_VAR}

    RUN comando1 && comando 2 é diferente de RUN comando1; comando2  pois com o ; ele vai rodar independente se deu certo ou não. Com && ele vai rodar se tudo der certo com o primeiro comando.

A ver mais tarde, mas a melhor forma de gerar log de um container não é num logfile. Docker já faz isso, o que devemos fazer é especificar quais ações devem ser escritas, tanto no stdout quanto no stderr. Logfiles geram complicação de como acessar e quem pode acessar.

EXPOSE
    PORTA_CONTAINER PORTA_HOST. Apenas o expose não faz com que as portas fiquem abertar automaticamente. O comando -p que irá fazer isso, portando ainda é necessário.

CMD
    Também é obrigatório assim como o from. Será explicado melhor mais tarde. Esse comando dever ser rodado quando o container estiver launched. Só um comando cmd é permitido. Se houver muitos cmd, o último prevalecerá.

    Diz os argumentos obrigatórios ao rodar um container com essa imagem.
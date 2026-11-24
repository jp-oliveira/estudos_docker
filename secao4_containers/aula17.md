**O que são containers?**

São o bloco de construção fundamental do docker tookit. É o primeiro conceito que deve ser aprendido. Antes mesmo de construir imagens ou qualquer outro material mais avançado.

O que são, como executá-los, como são diferentes de uma VM e outras funcionalidades básicas.

Faremos várias operações com container usando Nginx (web server). Criar, deletar e fazer os containers se comunicarem

>docker version

O server é também chamado de engine, que está rodando em background na nossa máquina.

Em windows é chamado de serviço, em linux e mac é chamado de deamon.

Nosso docker command line está falando com o servidor na minha máquina e retornando os seus (do servidor) valores, bem como os do client.

client e server devem ser preferencialmente na mesma versão, porém não obrigatoriamente.

Se server respondeu, é um sinal que posso me comunicar obviamente e tudo está funcionando ok.

>docker info
retorna muuuita coisa, uma dessas é a informação de quantos containers e quantas imagens estão rodando.

> docker
devolve todos os comandos possíveis.

docker tem os management commands - o que quer dizer que são formas atuais de rodar comandos antigos.

como docker tem retrocompatibilidade, ambos os comandos funcionam:

docker container run - versão nova, com o container sendo o management.

docker run - segue funcionando.

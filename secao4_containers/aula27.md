**Alguns conceitos de rede em docker**

O que de fato acontece quando startamos um container?

Estamos, em background, conectando cada container com uma vpn ponte

cada rede virtual roteia por meio de um firewall NAT no ip do host, o que significa o daemon do coker configurando o endereço ip do host on its default interface so that your containers can get out to the internet or to the rest of yout network and then get back

Contudo, não precisamos do comando -p para fazer com que os containers se comuniquem entre si dentro do host. Eles podem conversar entre si sem abrir as portas para o resto da rede. Pode haver uma vpn entre eles.

O bom do docker: "Batteries included, but removable" - signifca que o que vem por padrão funciona em muitos casos, porém é fácil para trocar algumas partes e customizar. Podemos configurar algumas opções tanto em tempo de execução ou não.

Voltando ao penúltimo parágrafo: Ou seja, podemos anexar containers a uma OU MAIS redes privadas (ou até mesmo nenhuma).

Podemos inclusive ignorar essas redes privadas e usar o próprio ip do host (usando --net=host). Isso pode perder algum dos benefícios da conteinirização, mas pode ser útil em outros cenários.

RELEMBRANDO:

docker container run --name NOME -d -p 80:80 nginx

-p vem de -publishing, o formato é PORTADOHOST:PORTADOCONTAINER

para ver o que está rodando em cada porta de um determinado container:
docker container port webhost

E para descobrir o ip do container? NÃO é o mesmo do host.

docker container inspect --format "{{ .NetworkSettings.IPAddress }}" NOMEDOCONTAINER

Esse padrão segue uma sintaxe da linguagem GO - Go Templates. Se quiser saber o ip com comandos linux mesmo:

sudo docker container inspect NOME_CONTAINER | grep -i "IPAddress"

Importante frisar que o ip do host e do container NÃO são os mesmos.
o container continua acessível apenas através do localhost (graças à ponte de portas que você fez). Esse IP interno serve principalmente para os containers conversarem entre si.

Vale a pena avaliar manter certos containers em redes privadas SEPARADAS, de modo a só deixar na mesma os containers que necessitam se comunicar entre si.

para criar uma nova rede:
PRÓXIMA AULA

Apenas para relembrar, não podemos escutar no host mais do que 1 porta para múltiplos containers. ou seja, não podemos ter 2 containers ouvindo a mesma porta 80 no host.

Para as próximas aulas:

Ao usar o comando ping em imagens nginx, oerceberá que não está mais como nativo. Pode:

instalá-lo com apt-get install ping ou simplesmente trocar nginx por nginx:alpine, que já tem o ping instalado.

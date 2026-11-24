**Containers e DNS**

Redes Padrão != Redes Personalizadas
Como lidam com o DNS?

1 = Dar um bom nome (DNS) para containers e redes virtuais. Há muitas operações que são feitas com containers, por isso é uma boa prática pensar nos containers pelo NOME e não pelo IP estático ou o vigente. Não pudemos supor que daqui a 1 minutos os endereços IP's serão os mesmos. Pode haver falha ou alguma modificação do próprio docker.
Por exemplo, se eu parar um container e startar de novo, ele pode mudar de ip.

Uma solução interna para isso é a boa nomeação de DNS. O Dockers usa o nome do container como o equivalente a um nome de host quando containeres conversarem entre si.

Docker daemon tem um servidor DNS interno que os containeres usam por padrão.

Novas redes criadas recebem um novo recurso especial - resolução automática de DNS para todos os containers nessa rede virtual de todos os outros containeres dessa rede virtual usando seus nomes de containeres.

O docker padroniza o hostname para o nome do container, mas os aliases não podem ser setados.

para verificar se containers de uma mesma rede estão se enxergando:

docker container exec -it CONTANER_1 ping OUTRO_CONTAINER_DA_MESMA_REDE e vice versa.

A rede bridge NÃO TEM um servidor DNS built-in por default. Nesse caso, pode-se usar --link. Porém é muuuito mais fácil criar uma rede nova e com isso, ir colocando os containeres nessa nova rede.

Vai facilitar com Docker Compose (veremos na frente)

docker container -rm -it ubuntu:14.04 bash = depois que der o exit no bash o container já vai ser removido
# Entendendo Docker Registry

Falamos sobre como docker registry pode ser um registro armazenado na própria rede.

Falamos que pode ser parte do docker/distribuição do repositório github.

Use o registry do dockerhub, não o legado do github. simplesmente faça docker pull registry.

É O registro backend "defacto" para armazenar seus containers privadamente.

É bem básico. Não tem WebGUI, não é como dockerhub. Suporta certificado e autenticação apesar de não estarem habilitados por default. A autenticação na verdade é tudo ou nada. Não é RBAC (Role based access control).

É provavelmente útil apenas em times pequenos, não é escalável.

É, no seu cerne, uma API web e sistema de armazenamento para lidar com todas essas imagens largas que iremos lidar. curiosidade: é escrita em GO.

Um lado bom nisso tudo é que vem com drivers de armazenmento que permitem colocar o armazenamento backend em S3/Azure/Alibaba/Google Cloud/OpenStack Swift. Usaremos o local por default. Usando volumes.

Olhe os links deixados na aba de recursos para:

    - Deixe seu registro seguro com TLS. Obviamente vc não vai habilitar o registro inseguro.

    - Cuidado com o garbage collector. Olhe o artigo para checar armazenamento e eliminar imagens antigas que já não têm mais uso:
    <https://distribution.github.io/distribution/about/garbage-collection/>

    - Permtir cacheamento do hub via "--registry-mirror"
    Se você está buildando em produção e não quer depender do dockerhub para muitas de suas imagens base, então o que vc pdoe fazer é habilitar um modo proxy e falar para seus docker daemons (instâncias) para usar o proxy, cacheando assim qualquer imagem do hub dentro do registro. 
    
    Isso vai otimizar usa largura de banda caso vc lide com muitos servidores por exemplo. Evita por exemplo baixar a mesma imagem em vários servidores. Também é bom para ter as imagens locamente caso o hub dê algum problema.
    
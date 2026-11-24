> Questões principais

Containers são, por definição, imutáveis e temporários.

Veremos como persistir dados, como passar dados de um container para outro, como criar e editar dados presentes em um container, etc.

Como eles são imutáveis por definição, não se pode dizer que é uma limitação do container, mas simplesmente uma boa prática, ou o design ao qual ele foi criado.

"infraestrutura imutável" = somente "redeploy" containers, nunca muda.

Existem duas formas de se lidar com isso: 
Volumes = opção de configuração para um container que cria um lugar especial fora do UFS (union file system) do container para armazenar dados únicos. Isso nos permite anexar os dados a qualquer container, não a somente um. Para o container, é só um local path.

Bind Mounts = Compartilhar ou montar(mount) um host diretório (ou arquivo) dentro de um container. Novamente, Para o container será só um local path. O container não vai saber que vem do host.
**WSL2**

Windows subsystem for linux

Melhor maneira de executar o linux no windows.

EULA

primeiro: instalar docker desktop
segundo: instalar wsl2

Garantir que o kernel linux dentro da   wsl2 seja atualizado para uma versão mais recente.

O download de uma imagem de docker para que vc possa rodar containers é chamado de pull, similar ao git pull. Isso requer acesso ao dockerhub.

Caso haja um erro ao tentar iniciar o docker ou caso tente rodar um comando docker e ele não estiver funcionando corretamente, pode ser que não tenha as extensões habilitadas na cpu na bios para virtualização.

Este curso requer docker rodando localmente na docker desktop para rodar em virtualização.

A menos que estejamos rodando em um servidor linux em algum lugar, normalmente não há necessidade de virtualização em linux pq ele roda nativamente. No windows, usaremos em uma vm em nosso hardware local. É mais seguro para o docker e para a máquina.

tweaks - ajuste.

Em todo subsistema windows para linux, precisaremos usar um shell linux para entrar naquela VM que roda.

Sempre que outro wsl for instalado, vai ser exibido em:
settings > resources > wsl integration

Agora, ao ir na windoes store, podemos baixar várias distribuições diferentes. É preciso uma para interagir com o docker no linux. Tecnicamente não precisa, mas é fortemente recomendado.

É, por exemplo, nessa distribuição UBUNTU que todos os seus containers vão funcionar em servidores de qualquer maneira.

esse ubuntu é como se fosse uma mini linux vm.

UNIX username escolhido: jotape_oliveira
senha de sempre.

Posso instalar debian, kali-linux, qualquer um.

NÃO USAR powershell ou cmd. use ubuntu shell, é mais recomendado.

Se quiser usar algo do próprio windows, no win11 já vem como padrão, mas no win10 é possivel baixar do windows store: windows powershell.

**rever o vídeo caso queira mudar o windows power shell para o padrão**
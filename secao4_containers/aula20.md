**Diferenças entre containers e vm's**

 Containers
    - são somente processos rodando no nosso SO;
    - limitados a quais recursos podem acessar;
    - Para de existir quando o processo para.


docker top <NOME>

lista os prcessos rodando em um container específico.

Para exemplificar o que está sendo falado, Se vc rodar todos os processos do pc vc vai ver o processo com o nome que vc deu lá.

obs: em linux seria ps aux para listar todos os processos do pc. Em Mac/Windows, docker está rodando em uma mini VM, então se quiser rodar ps também nesses so, será necessário conectar com o Docker VM. Ver os recursos desse episódio.

De qualquer forma, é um processo, não está escondido dentro de uma VM que não podemos acessar.

Como já mostrado na aula 18, se rodarmos:
docker stop <NOME> e depois 
docher ps ou 
docker top <NOME> 
ele não vai estar mais lá.

ps aux | grep NOME para procurar no linux algum processo específico.

Se fizermos:
docker start <NOME> ele vai voltar a rodar o container que já existe porém está parado.
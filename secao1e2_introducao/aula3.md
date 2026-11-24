## Porque o docker existe?

Isolation
Environments
Speed

The problem of Isolation = imagina varias stacks no mesmo ambiente, no mesmo servidor. Tipo python e php, por exemplo. Compartilhando os mesmos filesystem, mesmos recursos.

Depois vieram as VM's. Porém começou a haver muita vm para pouco gerenciador, deixando a tarefa complexa.

Como o docker pode ajudar?
- Endereço IP Próprio
- File System próprio
- Espço de processo próprio
- Gerenciamento de dependências mais fácil
- Diminuição, quase eliminação das diferença de ambiente. muda apenas variáveis de ambiente, duuuh

É quase uma VM, mas você não precisa de todos os diferentes SO nos hosts e não vai mais precisar de VM's para isolar.

Ao invés de usar conexões SSH por exemplo use docker.

Vantagens - posso usar diferentes versões do mesmo app no mesmo sistema sem nenhum conflito.

Onde quer que o container seja rodado, será executado da mesma maneira consistente com as mesmas dependências, exatamente como foi construído.

Com docker:

Develop faster
build faster
test faster
deploy faster

increase speed of change - as imagensde containers são muito mais fáceis de construir, deployar, reinplantar e executar.
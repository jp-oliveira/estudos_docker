> Teste

Melhor prática:
Não atualizar a aplicação nos containers, mas ao invés disso substituir o container por uma nova versão.

docker container run -d --name container16 -e POSTGRES_HOST_AUTH_METHOD=trust -v volume_duplo:/var/lib/postgresql/data postgres:16

NÃO ESQUECER DOS COMANDOS:

docker container logs nome_container

se eu rodo esse log com -f, de follow, ele vai mostrar tbm os logs que vão surgindo.

Entre o 16 e o 17 deu problema pq o volume não pode ser o mesmo para versões com o primeiro número diferente em postgres.

Com 15.1 e depois com 15.2 dá certo.

PERGUNTA PARA AS PRÓXIMAS AULAS
Com Bind Mounts, uma boa forma de perceber que o mapeamento está correto é editando os arquivos.
Porém, como rodo os containers dentro da vm do linux, não consigo abrir por exemplo o vs code lá para editar. Como editar os arquivos que estão dentro do linux? sim, existe o vim e o nano, mas não são tão amigáveis.

Posso iniciar os containers FORA do linux?? tem problema?
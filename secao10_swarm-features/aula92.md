> Segredos

Solução mais fácil para armazenar segredos em swarm.

Mas o que é segredo? qualquer coisa que vc precisar esconder, que seja uma informação que não deva ficar exposta.

- Senhas e usuários
- Certificados TLS e chaves
- Chaves SSH
- Chaves de conexão com API's
- etc

Suporta strings genéricas ou binários contendo no máximo 500 Kb 

Está encriptado em disco.
Só é armazenado em disco nos nós gerentes, só eles podem abrir e desencriptar os segredos.

Para saber mais sobre qual protocolo de encriptação e como ele é usado, veja o video.

Segredos são armazenados primeiramente no swarm e depois atribuídos a um ou mais serviços.

Apenas containers nos serviços atribuídos podem ver os segredos.

Eles parecem arquivos em container mas na verdade estão em memória fs.

/run/secrets/<secret_name_or_alias>

Um segredo pode ter vários alias.

Lembre: docker-compose, o CLI, nunca deve ser usado em produção ou em um servidor de produção.

docker-compose local pode usar segredos baseados em arquivo, mas não seguros.

Segredos dependem de swarm. Armazenamos segredos na base de dados do swarm. Logo, obviamente se vc não tem swarm, você não pode ter segredos.

Entretanto, docker-compose command tem uma maneira de "mount" os segredos em um arquivo de texto no local container. Não é seguro, mas nos permite usar em localhost. Obviamente, não deve ser feito assim em produção.
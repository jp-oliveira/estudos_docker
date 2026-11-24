Docker ou qualquer outro container exige a imagem do recipiente para rodar sobre um núcleo que foi projetado pra isso.

Obviamente se vc construir um app para windows, ele terá que rodar no windows.

Porém, a grande maioria dos containers roda em um kernel linux, que significa que quando você instala Docker Desktop ou qualque outra ferramenta alternativa de rodar container, esssas ferramentas gerenciarão uma VM local rodando um pequeno kernel linux e um pequeno sistema de arquivos de containers.

No windows, no mac e até mesmo no linux, O Docker Desktop fará uma VM Linux por conta própria. Ele também, em segundo plano, atualizará versões e se preocupará com segurança e vpn's.

3 majors ways to run containers:
Localmente (Docker Desktop, RD)
Servidores (Docker Engine, K8s)
Paas (Cloud Run, Farmgate)

OCI
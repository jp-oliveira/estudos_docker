** Shell vs Exec Forms **

Shell Form - é só uma string, mais vista nos comandos RUN. O binário usado no shell form pode ser alterado. As vezes, é até necessário.

```dockerfile
RUN apt-get update && apt-get upgrade-y
```

Exec Form = É como se fosse um json, com colchetes e aspas da exata forma exibida abaixo. GARANTE que o processo especificado execute diretamente como PID1 (process id), sendo então capaz de receber sinais e não roda como um subprocesso, como shellform faz.

```dockerfile
ENTRYPOINT ["startup.sh"]
CMD ["python", "server.py"]
```

APESAR DO COMANDO ABAIXO **NÃO FUNCIONAR** EM EXEC FORM, todos os env setado no dockerfile ainda vão ser acessíveis pelo programa rodado com Execform.

```dockerfile
CMD ["PORT=$PORT", "node", "server.js"]
```

---------"COMANDO" SHELL -----------------

SHELL default em containers linux:

```dockerfile
SHELL ["/bin/sh", "-c"]
#or
SHELL ["powershell", "-command"]
```

Ou seja, a shell form vai injetar "/bin/sh -c" no começo do comando.

Se o SHELL for declarado, irá sobreescrever o SHELL padrão.

SHELL default em containers windows:

```dockerfile
SHELL ["cmd", "/S", "/C"]
```

------------------------------------------

O Comando shell sempre precisa usar a Exec form.

Em linux, não é muito comum alterar o comando SHELL porque todas as imagens já contam com SH shell.

Quando usar cada forma?

COMANDOS

**Run** = usar shell por padrão.

ShellForm(adequada):

```dockerfile
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*
```

ExecForm(não recomendada):

```dockerfile
RUN ["apt-get", "update", "&&",
    "apt-get", "install", "-y", "--no-install-recommends", "curl",
    "&&", "rm", "-rf", "/var/lib/apt/lists/*"]
```

Na verdade nem funciona, até porque sem shellform se perde as vantagens do shellform: substituição de variáveis, comandos encadeados com aspas duplas, piping output, etc.

**ENTRYPOINT** = Sempre Exec ou o CMD não vai funcionar.

**CMD** = Exec por padrão. Raramente Shell Form será necessário para funcionalidades shell. Ex: Quando nao tem ENTRYPOINT e o CMD precisa de algumas funcionalidades Shell, como encadear comandos ou substituir variáveis.

**ENTRYPOINT + CMD** = Sempre use EXEC para evitar bizarrices.

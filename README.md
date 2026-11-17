# Minecraft Java Vanilla — Codespaces

Servidor Vanilla para até 5 jogadores. O script baixa automaticamente a última versão **estável** publicada pela Mojang e verifica o SHA-1 do arquivo.

## Como iniciar

1. Abra este repositório no GitHub e selecione **Code → Codespaces → Create codespace on main**.
2. Aguarde a criação do ambiente e a instalação do Java 25.
3. No terminal do Codespace, execute:
   ```bash
   ./start.sh
   ```
4. Na primeira execução, o script baixa o servidor e cria `eula.txt`, mas **não inicia o jogo**.
5. Leia https://aka.ms/MinecraftEULA. Se concordar com os termos, edite `eula.txt` e troque `eula=false` por `eula=true`.
6. Execute `./start.sh` novamente.
7. Na aba **Ports**, localize a porta `25565`. Para conexões externas, altere a visibilidade para **Public**, se essa opção estiver disponível. Compartilhe o endereço encaminhado com os jogadores.

## Configuração

- Edição: Java
- Software: Vanilla oficial da Mojang
- Versão: última release estável (não usa snapshots)
- Máximo: 5 jogadores
- Autenticação: online-mode ativado
- Porta: TCP 25565

## Importante

- Codespaces não é hospedagem 24 horas. O ambiente pode parar por inatividade, limites de uso ou encerramento da sessão.
- O encaminhamento público de portas depende das políticas e limites da conta. Teste a conexão de fora do Codespace antes de convidar os jogadores.
- Faça backup da pasta do mundo antes de recriar ou excluir o Codespace.
- Este servidor é para clientes **Minecraft Java Edition**. Não presume compatibilidade com Minecraft Bedrock, Starling ou outras implementações.

# codexcli

CLI minimalista para interagir com o modelo gpt-5 usando as mesmas instruções do projeto openai/codex, com cache local e fallback offline via submódulo.

## Instalação rápida

Linux/macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/lucasliet/codexcli/main/install.sh | bash
```

Atualiza se já instalado; cria symlinks em `~/.local/bin` e garante que essa pasta entre no `PATH` via shell rc (`.zshrc`, `.bashrc` ou `.profile`).

## Desinstalação

```bash
curl -fsSL https://raw.githubusercontent.com/lucasliet/codexcli/main/uninstall.sh | bash
```

Remove os symlinks de `~/.local/bin` e apaga o diretório `~/.local/share/codexcli`.

## Uso

Texto:

```bash
codexcli "seu prompt aqui"
```

Imagem + texto:

```bash
codexcli --image path/to/image.png --prompt "Descreva a imagem"
```

Se nenhum caminho de imagem for fornecido, o script usará a imagem mais recente no diretório atual. A flag `--prompt` é opcional e o padrão é "Explain what is in this image.".

Pré-requisitos:

- `jq`, `curl`, `uuidgen`, `file`, e `base64` disponíveis no sistema.
- Arquivo `~/.codex/auth.json` contendo `tokens.access_token` e `tokens.account_id`.
- É necessário ter efetuado login pelo menos uma vez no Codex oficial para que o arquivo `~/.codex/auth.json` seja criado.

## Atualização de instruções do Codex

Os scripts leem os arquivos Markdown diretamente do submódulo `vendor/openai-codex` e tentam atualizá-lo oportunisticamente via `git` (sem bloquear a execução). Não há cache em `/tmp`; o próprio submódulo faz o papel de cache local.

Ordem de obtenção:

1. Submódulo em `~/.local/share/codexcli/vendor/openai-codex`
2. Caminho local `~/Projetos/codex` (se existir)
3. Sem cache em `/tmp`; leitura direta do submódulo

Variáveis:

- `CODEX_INSTRUCTIONS_TTL` (padrão `86400` segundos) controla a frequência com que tentamos atualizar o submódulo.

## Atualização do submódulo vendorizado

Se instalado via `git`, o script tenta atualizar `vendor/openai-codex` oportunisticamente, respeitando o TTL de `CODEX_SUBMODULE_TTL`.

## Manual (opcional)

Clonar e instalar manualmente:

```bash
git clone https://github.com/lucasliet/codexcli
cd codexcli
./install.sh
```

## Licença

Veja o repositório para detalhes de licença.

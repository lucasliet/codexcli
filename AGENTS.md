# Repository Guidelines

## Project Structure & Module Organization
- `codexcli`: CLI principal em Bash com suporte a texto e imagem.
- `install.sh` / `uninstall.sh`: instalação e remoção de symlinks e dados locais.
- `docs/`: scripts de referência e exemplos de uso.
- `vendor/openai-codex` (submódulo): fonte das instruções oficiais usadas pelo CLI.
- `README.md`: visão geral, instalação e uso.

## Build, Test, and Development Commands
- `./install.sh`: instala o CLI em `~/.local/bin/codexcli` e prepara o vendor.
- `./uninstall.sh`: remove symlinks e dados locais do codexcli.
- `./codexcli --help`: ajuda rápida e flags suportadas.
- `./codexcli "seu prompt"`: executa fluxo de texto.
- `./codexcli --image path.png --prompt "Describe..."`: executa visão+texto.
- `git submodule update --init --recursive`: garante `vendor/openai-codex` sincronizado.

## Coding Style & Naming Conventions
- Linguagem: Bash, compatível com ambiente POSIX, evitando dependências não essenciais.
- Indentação: 2 espaços; linhas curtas e legíveis; nomes claros.
- Prefixos: variáveis e funções internas com `CODEXCLI_`/`codexcli_`.
- I/O: use `jq` para JSON, `curl` com flags explícitas e erros tratados.
- Erros: valide pré‑requisitos, retorne código não‑zero em falhas e mensagens objetivas.

## Testing Guidelines
- Smoke tests locais: `./codexcli "ping"`, `./codexcli --image img.png --prompt "Explain..."`.
- Lint: `shellcheck codexcli`.
- Formatação: `shfmt -i 2 -w codexcli`.
- Não há cobertura obrigatória; mantenha casos manuais reproduzíveis na descrição do PR.

## Commit & Pull Request Guidelines
- Commits: Conventional Commits (ex.: `feat(codexcli): suporte a imagem`).
- PRs: descrição clara, passos de reprodução, saída esperada/obtida, itens afetados.
- Escopo: não altere `vendor/openai-codex`; atualizações do vendor são oportunistas.
- Inclua exemplos de execução e verifique que `~/.codex/auth.json` não vaza em logs.

## Security & Configuration Tips
- Nunca versione credenciais; não exponha `~/.codex/auth.json`.
- Mascarar tokens em logs e prints.
- Variáveis úteis: `CODEX_INSTRUCTIONS_TTL` para controlar atualização do vendor.
- Evite mudanças que alterem o comportamento de streaming ou ampliem permissões.


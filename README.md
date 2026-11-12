# hrbocutti/homebrew-tap

## shared-peripherals (`sp`)

`sp` compartilha teclado e mouse entre dois Macs por UDP de baixa latência. A hotkey `Fn + \`` passa o controle de um Mac para o outro. O binário é universal (Apple Silicon e Intel).

```sh
brew install hrbocutti/tap/shared-peripherals
```

### Sem `git clone` (redes que bloqueiam repositórios externos)

```sh
brew tap-new hrbocutti/tap --no-git
mkdir -p "$(brew --repo hrbocutti/tap)/Formula"
curl -fsSL https://raw.githubusercontent.com/hrbocutti/homebrew-tap/main/Formula/shared-peripherals.rb \
  -o "$(brew --repo hrbocutti/tap)/Formula/shared-peripherals.rb"
brew install hrbocutti/tap/shared-peripherals
```

Para atualizar, rode o `curl` de novo e depois `brew upgrade shared-peripherals`.

### Uso

```sh
mkdir -p ~/.config/shared_peripherals
cp "$(brew --prefix shared-peripherals)/share/shared-peripherals/config.example.toml" ~/.config/shared_peripherals/config.toml
# edite: peer = "<outro-mac>.local"

sp echo                          # no outro Mac
sp bench --peer <outro>.local    # mede latência, jitter e perda
sp run                           # nos dois Macs (ou: brew services start shared-peripherals)
```

Na primeira execução, o macOS pede **Acessibilidade** e **Monitoramento de Entrada**. Conceda em Ajustes do Sistema → Privacidade e Segurança.

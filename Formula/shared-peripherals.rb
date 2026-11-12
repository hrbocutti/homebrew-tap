# typed: true
# frozen_string_literal: true

# Compartilha teclado e mouse entre dois Macs (binário `sp`).
class SharedPeripherals < Formula
  desc "Compartilha teclado e mouse entre dois Macs via UDP de baixa latência"
  homepage "https://github.com/hrbocutti/homebrew-tap"
  url "https://github.com/hrbocutti/homebrew-tap/releases/download/shared-peripherals-v0.1.0/shared-peripherals-0.1.0-macos-universal.tgz"
  version "0.1.0"
  sha256 "c16e4cf7842ad1deff0c35ecc65aab340b95358322100b52f1fdddbcbd70da00"

  depends_on :macos

  def install
    bin.install "sp"
    pkgshare.install "config.example.toml"
  end

  service do
    run [opt_bin/"sp", "run"]
    keep_alive true
    process_type :interactive
    log_path var/"log/shared-peripherals.log"
    error_log_path var/"log/shared-peripherals.log"
  end

  def caveats
    <<~EOS
      1. Configure o outro Mac (peer):
           mkdir -p ~/.config/shared_peripherals
           cp #{opt_pkgshare}/config.example.toml ~/.config/shared_peripherals/config.toml
           # edite: peer = "<outro-mac>.local"

      2. Teste a rede:   sp echo  (no outro Mac)   |   sp bench --peer <outro>.local
      3. Rode:           sp run                    (ou: brew services start shared-peripherals)

      Na primeira execução conceda Acessibilidade e Monitoramento de Entrada
      (Ajustes do Sistema → Privacidade e Segurança) ao Terminal, ou a
      #{opt_bin}/sp quando rodar via brew services. A cada nova versão o macOS
      pode pedir as permissões de novo.

      Atalho padrão: Fn + `  (veja `sp keys` para teclados ABNT/ISO)
    EOS
  end

  test do
    assert_match "teclado e mouse", shell_output("#{bin}/sp help")
  end
end

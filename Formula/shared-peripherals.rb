# typed: true
# frozen_string_literal: true

# Compartilha teclado e mouse entre dois Macs (binário `sp`).
class SharedPeripherals < Formula
  desc "Compartilha teclado e mouse entre dois Macs via UDP de baixa latência"
  homepage "https://github.com/hrbocutti/homebrew-tap"
  url "https://github.com/hrbocutti/homebrew-tap/releases/download/shared-peripherals-v0.3.1/shared-peripherals-0.3.1-macos-universal.tgz"
  sha256 "06681e49bfc762cb6f0133eac4a9f32341516422ecdb60236ef12df6520989c3"

  depends_on :macos

  def install
    bin.install "sp"
    pkgshare.install "config.example.toml"
  end

  service do
    run [opt_bin/"sp", "run", "--foreground"]
    # reinicia só se cair; "Sair" no menu encerra de verdade
    keep_alive crashed: true
    environment_variables SP_LOG_PATH: "#{var}/log/shared-peripherals.log"
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

      2. Rode nos dois Macs:  sp run   (vai para segundo plano, com ícone na barra de menus)
         ou como serviço:     brew services start shared-peripherals
         Pelo ícone você vê os IPs, escolhe o outro Mac e liga/desliga a borda.
         Parar: sp stop  (ou "Sair" no menu)

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

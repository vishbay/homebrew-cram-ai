class CramAi < Formula
  desc "Cut AI coding token costs by 96-98% — curated context, MCP server, and tray app"
  homepage "https://github.com/vishbay/cram-ai"
  url "https://files.pythonhosted.org/packages/d7/16/da6faacd5fed219309295d201d07e833d9126d954bccc58020e83c5d6fdc/cram_ai-0.1.0.tar.gz"
  sha256 "f4b761e618c9ca5f173b75cab659ef173f6ba38125364c3e768c080341d0c628"
  license "MIT"

  depends_on "python@3.12"

  # Homebrew tries to rewrite dylib IDs in libexec, but jiter's pre-built wheel
  # has a Mach-O header too small for the absolute path. The venv works fine —
  # skip_clean prevents the noisy (non-fatal) warning.
  skip_clean "libexec"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"

    # Isolated virtualenv in #{libexec} — keeps our pip deps off the system Python
    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip", "--quiet"

    # Install cram-ai with tray extras (pystray + Pillow + pywebview + Flask)
    # and the MCP extra for Claude Code / agent integration
    system libexec/"bin/pip", "install",
      "cram-ai[tray,mcp]==#{version}",
      "--quiet"

    # Expose CLI entry points into Homebrew's bin
    %w[cram cram-menu cram-autostart].each do |script|
      bin.install_symlink libexec/"bin"/script
    end
  end

  # `brew services start cram-ai` launches the menu bar tray at login
  service do
    run [opt_bin/"cram-menu"]
    keep_alive false
    log_path var/"log/cram-ai.log"
    error_log_path var/"log/cram-ai.log"
  end

  test do
    assert_match "Usage: cram", shell_output("#{bin}/cram --help")
    assert_match "cram", shell_output("#{bin}/cram status 2>&1 || true")
  end
end

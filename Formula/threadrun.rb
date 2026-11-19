class Threadrun < Formula
  desc "Runs coding agents in sandboxes on your computer or your own server"
  homepage "https://threadrun.dev/"
  url "https://threadrun.dev/downloads/Threadrun-macos.zip"
  version "1.3.0"
  sha256 "1c69f0df9c90548c3baebb24881d78f753d8788cda18985fda81ce92e4cdeb4d"
  license "Apache-2.0"

  depends_on :macos

  livecheck do
    url "https://threadrun.dev/downloads/latest.json"
    strategy :page_match do |page|
      page[/"version"\s*:\s*"v?([\d.]+)"/, 1]
    end
  end

  def install
    # The app installs, and later updates, itself in /Applications, the same way the zip download does.
    # The formula tracks the released version so that `brew update` picks up the next one.
    quiet_system "osascript", "-e", 'quit app "Threadrun"'
    rm_rf "/Applications/Threadrun.app"
    system "ditto", buildpath/"Threadrun.app", "/Applications/Threadrun.app"
  end

  def caveats
    <<~EOS
      Threadrun updates itself. Run `brew update` before `brew upgrade` so Homebrew knows the newest release.
      `brew uninstall` removes the version Homebrew installed; drag /Applications/Threadrun.app to the Trash.
    EOS
  end
end

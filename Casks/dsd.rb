# Homebrew cask for dsd. The homebrew workflow copies it to github.com/FChmiel/homebrew-dsd (Casks/dsd.rb),
# filling in `version` and `sha256`, when a release is published.
# Install:   brew install --cask fchmiel/dsd/dsd
cask "dsd" do
  version "0.1.1"
  sha256 "5774132413cd5b47b0bfaab1f37f0ed940ef0eaa87678c5980cd54a5f267e1c5"

  url "https://github.com/FChmiel/dsd/releases/download/v#{version}/dsd_#{version}_aarch64.dmg"
  name "dsd"
  desc "Workspace for agent-data science collaboration"
  homepage "https://github.com/FChmiel/dsd"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "dsd.app"
  # The app bundles its own backend; expose it as the `dsd` command (Claude Code runs `dsd mcp`).
  binary "#{appdir}/dsd.app/Contents/Resources/backend/dsd/dsd"

  postflight do
    # Tester builds are not notarized yet: clear the download quarantine so macOS will open the app.
    # Delete this block once releases are signed with a Developer ID and notarized.
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/dsd.app"]
  end

  # ~/.dsd is deliberately not zapped: it holds your projects' docs, plans and runs, and git worktrees (possibly unmerged work).
  zap trash: [
    "~/Library/Application Support/dev.dsd.app",
    "~/Library/Caches/dev.dsd.app",
    "~/Library/Logs/dev.dsd.app",
    "~/Library/WebKit/dev.dsd.app",
  ]
end

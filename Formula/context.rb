class Context < Formula
  include Language::Python::Virtualenv

  desc "A CLI tool to copy project context to the clipboard for LLMs"
  homepage "https://github.com/yigitkonur/code-to-clipboard-for-llms"
  url "https://github.com/yigitkonur/code-to-clipboard-for-llms/archive/refs/tags/v3.1.1.tar.gz"
  sha256 "8ea6e110c2692174044ce1299a2e7375882aa4b124c594aa747e52d16d457d2d"
  license "MIT"
  version "3.1.1"

  depends_on "python@3.11"

  resource "gitignore-parser" do
    url "https://github.com/yigitkonur/code-to-clipboard-for-llms/archive/refs/tags/v3.1.1.tar.gz"
    sha256 "8ea6e110c2692174044ce1299a2e7375882aa4b124c594aa747e52d16d457d2d"
  end

  resource "pyperclip" do
    url "https://github.com/yigitkonur/code-to-clipboard-for-llms/archive/refs/tags/v3.1.1.tar.gz"
    sha256 "8ea6e110c2692174044ce1299a2e7375882aa4b124c594aa747e52d16d457d2d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test that the command runs and shows help
    assert_match "Gather project context", shell_output("#{bin}/context --help")
  end
end

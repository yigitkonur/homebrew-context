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
    url "https://files.pythonhosted.org/packages/e5/51/e391a1a4238f18d0abb47be479b07af265ad4519022cf51b7da47ef82487/gitignore_parser-0.1.13.tar.gz"
    sha256 "c7e10c8190accb8ae57fb3711889e73a9c0dbc04d4222b91ace8a4bf64d2f746"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/30/23/2f0a3efc4d6a32f3b63cdff36cd398d9701d26cda58e3ab97ac79fb5e60d/pyperclip-1.9.0.tar.gz"
    sha256 "b7de0142ddc81bfc5c7507eea19da920b92252b548b96186caf94a5e2527d310"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test that the command runs and shows help
    assert_match "Gather project context", shell_output("#{bin}/context --help")
  end
end

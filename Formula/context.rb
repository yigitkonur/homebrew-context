class Context < Formula
  desc "A CLI tool to copy project context to the clipboard for LLMs"
  homepage "https://github.com/yigitkonur/code-to-clipboard-for-llms"
  url "https://github.com/yigitkonur/code-to-clipboard-for-llms/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "878afd54bee7ffc3331f9ba9a864678c2c4f5bec7625c23785e635374f51261a"
  license "MIT"

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
    # Create a dedicated virtual environment
    venv = virtualenv_create(libexec, "python3.11")

    # Install Python dependencies (resources) into the venv
    venv.pip_install resources

    # Install the main application from the source
    venv.pip_install_and_link buildpath

    # Create the executable wrapper script
    (bin/"context").write <<~EOS
      #!/bin/bash
      # Wrapper script that calls the Python script in its isolated environment
      exec "#{libexec}/bin/context" "$@"
    EOS
  end

  test do
    # Test that the command runs and shows help
    assert_match "Gather project context", shell_output("#{bin}/context --help")
  end
end
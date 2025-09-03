class Context < Formula
  desc "A CLI tool to copy project context to the clipboard for LLMs"
  homepage "https://github.com/yigitkonur/code-to-clipboard-for-llms"
  url "https://github.com/yigitkonur/code-to-clipboard-for-llms/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  depends_on "python@3.11"

  resource "gitignore-parser" do
    url "https://files.pythonhosted.org/packages/b5/d2/a6b57950b7a8d38ab9a8fa855c82662030f316270b21e42f6e9b462f43a9/gitignore_parser-0.1.12.tar.gz"
    sha256 "93a8e9117017cac9b819eb28f40ba02e6cd18eb5fa0f06de2c8f4141e4e592c5"
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
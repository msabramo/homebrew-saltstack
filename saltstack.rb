require 'formula'

class Saltstack < Formula
  homepage 'http://saltstack.org/'
  url 'https://github.com/downloads/saltstack/salt/salt-0.10.3.tar.gz'
  sha1 '01d95378dc00c6586ea2c25ccf79a2b3a9cf45c6'

  depends_on 'zeromq'
  depends_on 'swig' => :build

  def install
    # Add folders to path (Superenv removes these)
    # TODO: Move away from system virtualenv and use homebrew python
    ENV.append "PATH", "/usr/local/bin", ":"
    ENV.append "PATH", ( HOMEBREW_PREFIX / 'bin'), ":"
    system "virtualenv", "#{prefix}/salt.venv"
    system "#{prefix}/salt.venv/bin/pip", "install", "-r", "requirements.txt"
    system "#{prefix}/salt.venv/bin/python", "setup.py", "install"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-call"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-cp"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-key"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-master"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-minion"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-run"
    bin.install_symlink "#{prefix}/salt.venv/bin/salt-syndic"
  end

  def test
    system "salt --version"
  end
end

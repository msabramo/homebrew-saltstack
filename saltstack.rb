require 'formula'

class Saltstack < Formula
  homepage 'http://saltstack.org/'
  url 'https://github.com/downloads/saltstack/salt/salt-0.10.5.tar.gz'
  sha1 '42796c7299e0000c250af2b3164fa77ef4f5e460'

  depends_on 'python'
  depends_on 'zeromq'
  depends_on 'swig' => :build

  def patches
    # set salt config dir to live under Homebrew's etc dir
    'https://raw.github.com/gist/4139822/74f6adab3846cccb27b691c26b04e44a92defa06/gistfile1.diff'
  end

  def install
    # Add folders to path (Superenv removes these)
    ENV.append "PATH", "/usr/local/bin", ":"
    ENV.append "PATH", ( HOMEBREW_PREFIX / 'bin'), ":"
    system "#{HOMEBREW_PREFIX}/share/python/virtualenv", "#{prefix}/salt.venv"
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
    (etc+'salt').mkpath
  end

  def test
    system "salt --version"
  end
end

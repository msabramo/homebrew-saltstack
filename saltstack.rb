require 'formula'

class Saltstack < Formula
  homepage 'http://saltstack.org/'
  url 'https://github.com/downloads/saltstack/salt/salt-0.10.5.tar.gz'
  sha1 '42796c7299e0000c250af2b3164fa77ef4f5e460'

  depends_on 'swig' => :build
  depends_on 'python'
  depends_on 'zeromq'
  depends_on 'jinja2' => :python
  depends_on 'M2Crypto' => :python
  depends_on LanguageModuleDependency.new :python, 'PyCrypto', 'Crypto'
  depends_on LanguageModuleDependency.new :python, 'pyzmq', 'zmq'
  depends_on LanguageModuleDependency.new :python, 'PyYAML', 'yaml'
  depends_on LanguageModuleDependency.new :python, 'msgpack-python', 'msgpack'

  def patches
    # set salt config dir to live under Homebrew's etc dir
    'https://raw.github.com/gist/4139822/74f6adab3846cccb27b691c26b04e44a92defa06/gistfile1.diff'
  end

  def install
    system "python", "setup.py", "install"
  end

  def uninstall  # currently nonfunctional
    super
    system "pip", "uninstall", "salt"
  end

  def scripts_folder
    HOMEBREW_PREFIX/"share/python"
  end

  def caveats
    <<-EOS.undent
      To run the `salt` command, you'll need to add Python's script directory to your PATH:
        #{scripts_folder}
    EOS
  end

  def test
    system "salt --version"
  end
end

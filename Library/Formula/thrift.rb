require 'formula'

# TODO Fix java support anyone?
#
#

class Thrift <Formula
  homepage 'http://incubator.apache.org/thrift/'
  head 'http://svn.apache.org/repos/asf/incubator/thrift/trunk'
  version '20100228.053011-r917130'
  url 'http://dl.dropbox.com/u/119351/thrift-20100228.053011-r917130.tar.gz'
  md5 '384ac4f01ca5de15abdbccb364355d8d'

  depends_on 'boost'
  
  def install
    cp "/usr/X11/share/aclocal/pkg.m4", "aclocal"
    system "./bootstrap.sh" if version == 'HEAD'
    system "./configure","--disable-debug","--without-java",
                         "--prefix=#{prefix}","--libdir=#{lib}",
                         # rationale: this can be installed with easy_install
                         # and when you do that, it installs properly, we
                         # can't install it properly without leaving Homebrew's prefix
                         "--without-py",
                         # again, use gem
                         "--without-ruby",
                         "--without-perl",
                         "--without-php"
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    Some bindings were not installed. You may like to do the following:

        gem install thrift
        easy_install thrift

    Perl bindings are a mystery someone should solve.
    EOS
  end
end

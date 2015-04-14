require 'formula'

class Cgminer < Formula
  homepage 'https://github.com/ckolivas/cgminer'
  url 'https://github.com/He1lQ/cgminer/archive/4.9-U3.tar.gz'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'coreutils' => :build
  depends_on 'curl'

  def install
    inreplace "autogen.sh", "libtoolize", "glibtoolize"
    system "autoreconf -fvi"
    system "./autogen.sh", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "PKG_CONFIG_PATH=#{HOMEBREW_PREFIX}/opt/curl/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/jansson/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/libusb/lib/pkgconfig",
                          "--enable-icarus",
                          "--enable-bmsc"
    system "make", "install"
  end

  test do
    system "cgminer"
  end
end

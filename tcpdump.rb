require 'formula'

class Tcpdump < Formula
  homepage 'http://www.tcpdump.org/'
  url 'http://www.tcpdump.org/release/tcpdump-4.4.0.tar.gz'
  sha1 '6c1e72ae32eabb3ab823ff366a2d2f48ad4695f4'

  head 'git://bpf.tcpdump.org/tcpdump'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-smb",
                          "--disable-universal"
    system "make install"
  end
end

require 'formula'

class Libpcap < Formula
  homepage 'http://www.tcpdump.org/'
  url 'http://www.tcpdump.org/release/libpcap-1.4.0.tar.gz'
  sha1 '9c9710aab68be58ed1d41b5c36dc2599419a80e0'

  head 'git://bpf.tcpdump.org/libpcap'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make install"
  end
end

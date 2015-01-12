require 'formula'

class Groff < Formula
  homepage 'http://www.gnu.org/software/groff/'
  url 'http://ftpmirror.gnu.org/groff/groff-1.22.3.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/groff/groff-1.22.3.tar.gz'
  sha1 '61a6808ea1ef715df9fa8e9b424e1f6b9fa8c091'

  conflicts_with 'mdocml', :because => 'both install `groff` binaries'

  option 'with-gropdf', 'Enable PDF output support'
  option 'with-grohtml', 'Enable HTML output support (implies --with-gropdf)'
  option 'with-gpresent', 'Install macros for the presentations document format'

  if build.with? "grohtml"
    depends_on "ghostscript"
    depends_on "netpbm"
    depends_on "psutils"
  elsif build.with? "gropdf"
    depends_on "ghostscript"
  end

  resource 'gpresent' do
    url 'https://staff.fnwi.uva.nl/b.diertens/useful/gpresent/gpresent-2.3.tar.gz'
    sha1 '7d38165ad87ce418458275d0c04388dd0c651431'
  end

  patch :DATA # fix parallel build, https://savannah.gnu.org/bugs/index.php?43581

  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make" # Separate steps required
    system "make install"

    if build.with? 'gpresent'
      resource('gpresent').stage do
        (share/'groff/site-tmac').install Dir['*.tmac']
        (share/'groff/examples').install Dir['*.rof', '*.pdf']
        man7.install Dir['*.7']
        man1.install Dir['*.1']
        bin.install 'presentps'
      end
    end
  end

  def caveats
    <<-EOS.undent
    Attempting to use PDF or HTML output support without using --with-gropdf or
    --with-grohtml may result in errors.
    EOS
  end
end

__END__
diff --git a/Makefile.in b/Makefile.in
index bc156ce..70c6f85 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -896,6 +896,8 @@ $(GNULIBDIRS): FORCE
 	  $(MAKE) ACLOCAL=: AUTOCONF=: AUTOHEADER=: AUTOMAKE=: $(do) ;; \
 	esac
 
+$(SHPROGDIRS): $(PROGDEPDIRS)
+
 $(OTHERDIRS): $(PROGDEPDIRS) $(CCPROGDIRS) $(CPROGDIRS) $(SHPROGDIRS)
 
 $(INCDIRS) $(PROGDEPDIRS) $(SHPROGDIRS) $(OTHERDIRS): FORCE

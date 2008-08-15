# $Id: Makefile.PL 59185 2008-08-15 14:51:55Z wsnyder $
# DESCRIPTION: Perl ExtUtils: Type 'perl Makefile.PL' to create a Makefile for this package
#
# Copyright 2000-2008 by Wilson Snyder.  This program is free software;
# you can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License or the Perl Artistic License.

require 5.005;
use ExtUtils::MakeMaker;
use Carp;

sub MY::postamble {
"
DIST_DEFAULT += manifest

README: readme.texi
	-rm -rf \$@
	makeinfo \$< --output \$@ --no-headers --no-validate

## Maintainer use:
preexist:
	svnorcvs nexists \$(DISTNAME)_\$(VERSION_SYM)
	test -s README

tag:
	svnorcvs tag  \$(DISTNAME)_\$(VERSION_SYM)

maintainer-diff:
	svnorcvs diff \$(DISTNAME)_\$(VERSION_SYM)

maintainer-dist: README preexist dist tag
	svnorcvs release \$(DISTVNAME).tar.gz

maintainer-clean: distclean
	-rm -rf README

maintainer-copy: README

clean::
	-rm -rf test_dir MANIFEST.bak Makefile.old
";
}

WriteMakefile(
	      VERSION_FROM => 'lib/Module/LocalBuild.pm',
	      DISTNAME  => 'Module-LocalBuild',
	      NAME      => 'Module::LocalBuild',
	      AUTHOR	=> 'Wilson Snyder <wsnyder@wsnyder.org>',
	      ABSTRACT  => 'Detect module changes and rebuild into local area',
	      EXE_FILES => [qw(mlbuilder)],
	      PREREQ_PM => {
			    'Pod::Usage' => 0,
			},
	      'dist'    => {COMPRESS => 'gzip -9f',
			    SUFFIX   => '.gz',
			    DIST_DEFAULT => 'README all tardist',
			},
	      );

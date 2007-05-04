# $Id: localboot.pl 37762 2007-05-01 15:46:00Z wsnyder $
# Author: Wilson Snyder <wsnyder@wsnyder.org>
# DESCRIPTION: Example file that boots localbuild for testing
######################################################################
#
# Copyright 2007-2007 by Wilson Snyder <wsnyder@wsnyder.org>.  This
# program is free software; you can redistribute it and/or modify it under
# the terms of either the GNU Lesser General Public License or the Perl
# Artistic License.
#
######################################################################

use lib '../lib';  # So we find Module::LocalBuild
use Module::LocalBuild;
use Cwd;
BEGIN {
    Module::LocalBuild::need
	( dest_dir => getcwd()."/obj_localbuilt",
	  mlbuilder => "$^X ../mlbuilder",
	  # Areas we don't need to build, but need to add libraries for
	  libs => ["../t",  # Normally Foo/lib
		   ],
	  # It is important to include Module-LocalBuild in its own list
	  # otherwise changes in the build process won't be detected as changes!
	  packages => [getcwd().'/Module-LocalBuild',
		       ],
	  );
}

# Now see if we find what we need
use Stub;

# And, if that worked, a new subprocess should work too, as PERL5LIB changed.
my $PERL_NOLIB = $^X;
system ("$PERL_NOLIB -e 'use Stub'");

######################################################################

1;

#!/usr/bin/perl -w
# $Id: 30_localboot.t 38063 2007-05-04 13:00:44Z wsnyder $
# DESCRIPTION: Perl ExtUtils: Type 'make test' to test this package
#
# Copyright 2007-2007 by Wilson Snyder <wsnyder@wsnyder.org>.  This
# program is free software; you can redistribute it and/or modify it under
# the terms of either the GNU Lesser General Public License or the Perl
# Artistic License.

use strict;
use Test;
use ExtUtils::Manifest;

BEGIN { plan tests => 7 }
BEGIN { require "t/test_utils.pl"; }

use Module::LocalBuild;
ok(1);

# Clone the area so we self-test rebuilding it
run_system ("/bin/rm -rf test_dir");
mkdir "test_dir";
mkdir "test_dir/Module-LocalBuild";
# Copy ourself (the package) inside to the test_dir
my %files = %{ExtUtils::Manifest::maniread()};
delete $files{README};
ExtUtils::Manifest::manicopy(\%files, "test_dir/Module-LocalBuild", "cp");
ok(1);

# Run Perl, but ignore all library specifications involving this directory
# Else we won't prove that we're doing the right thing!
my $PERL_NOLIB = $^X;
run_system("cd test_dir ; $PERL_NOLIB ../t/localboot.pl");
#ok(1);    Stub prints an OK
#ok(1);    Stub prints an OK

# See if the build succeeded
print +(-f "test_dir/obj_localbuilt/blib/lib/Module/LocalBuild.pm"
	?"ok:\n" : "not ok:\n");

# Do it again.  It shouldn't need to rebuild
run_system("cd test_dir ; $PERL_NOLIB ../t/localboot.pl");
#ok(1);    Stub prints an OK
#ok(1);    Stub prints an OK

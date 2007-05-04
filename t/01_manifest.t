#!/usr/bin/perl -w
# $Id: 01_manifest.t 37649 2007-04-30 17:55:42Z wsnyder $
# DESCRIPTION: Perl ExtUtils: Type 'make test' to test this package
#
# Copyright 2007-2007 by Wilson Snyder.  This program is free software;
# you can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License or the Perl Artistic License.

use strict;
use Test;

BEGIN { plan tests => 1 }

if (!$ENV{VERILATOR_AUTHOR_SITE}) {
    skip("author only test (harmless)",1);
} else {
    eval { use ExtUtils::Manifest; };
    $ExtUtils::Manifest::Quiet = 1;

    my ($missing, $extra) = ExtUtils::Manifest::fullcheck();
    my $bad;
    foreach my $file (@{$missing}) {
	next if $file eq "README";
	warn "%Warning: MANIFEST listed file not found: $file\n";
	$bad = 1;
    }
    foreach my $file (@{$extra}) {
	warn "%Warning: MANIFEST maybe missing: $file\n";
	$bad = 1;
    }
    ok (!$bad);
}

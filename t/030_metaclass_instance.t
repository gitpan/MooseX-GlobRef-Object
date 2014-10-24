#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use Cwd;

BEGIN {
    unshift @INC, map { /(.*)/; $1 } split(/:/, $ENV{PERL5LIB}) if defined $ENV{PERL5LIB} and ${^TAINT};

    my $cwd = ${^TAINT} ? do { local $_=getcwd; /(.*)/; $1 } : '.';
    unshift @INC, File::Spec->catdir($cwd, 't/tlib');
};

use Test::Unit::Lite;

local $SIG{__WARN__} = sub { require Carp; Carp::confess("Warning: $_[0]") };

Test::Unit::HarnessUnit->new->start('MooseX::GlobRef::Meta::InstanceTestSuite');

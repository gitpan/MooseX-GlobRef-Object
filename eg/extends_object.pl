#!/usr/bin/perl

use lib 'lib', '../lib';

package My::IO;

use Moose;

extends 'MooseX::GlobRef::Object';

has 'file' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub open {
    my $fh = shift;
    open $fh, $fh->file or confess "cannot open";
    return $fh;
}

sub getlines {
    my $fh = shift;
    return readline $fh;
}

my $io = My::IO->new( file => $ARGV[0] || die "Usage: $0 *file*\n" );

print "::::::::::::::\n";
print $io->file, "\n";
print "::::::::::::::\n";
$io->open;
print $io->getlines;

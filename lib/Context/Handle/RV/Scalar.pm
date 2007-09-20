#!/usr/bin/perl

package Context::Handle::RV::Scalar;

use strict;
use warnings;

sub new {
	my ( $pkg, $code, $handle, @args ) = @_;

	my $val = $code->(@args);
	bless \$val, $pkg;
}

sub value {
	my $self = shift;
	$$self;
}

__PACKAGE__;

__END__

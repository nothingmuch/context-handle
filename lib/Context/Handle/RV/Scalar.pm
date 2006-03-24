#!/usr/bin/perl

package Context::Handle::RV::Scalar;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $pkg = shift;
	my $code = shift;
	my $val = uplevel 1, $code;
	bless \$val, $pkg;
}

sub value {
	my $self = shift;
	$$self;
}

__PACKAGE__;

__END__

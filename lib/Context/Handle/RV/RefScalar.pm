#!/usr/bin/perl

package Context::Handle::RV::RefScalar;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $self = shift;
	my $code = shift;
	$pkg->SUPER::new(sub { \${ uplevel 1, $code } });
}

__PACKAGE__;

__END__

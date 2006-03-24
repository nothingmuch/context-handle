#!/usr/bin/perl

package Context::Handle::RV::RefArray;
use base qw/Context::Handle::RV::Scalar/;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $class = shift;
	my $code = shift;
	
	$class->SUPER::new(sub { \@{ uplevel 1, $code } });
}

__PACKAGE__;

__END__

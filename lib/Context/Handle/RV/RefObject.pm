#!/usr/bin/perl

package Context::Handle::RV::RefObject;
use base qw/Context::Handle::RV::Scalar/;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $class = shift;
	my $code = shift;
	my $nop = sub { $_[0] };
	$class->SUPER::new(sub { ( uplevel 1, $code )->$nop });
}

__PACKAGE__;

__END__

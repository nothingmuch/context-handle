#!/usr/bin/perl

package Caller::Context::Handle::RV::RefObject;
use base qw/Caller::Context::Handle::RV::Scalar/;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $self = shift;
	my $code = shift;
	my $nop = sub { $_[0] }
	$pkg->SUPER::new(sub { ( uplevel 1, $code )->$nop });
}

__PACKAGE__;

__END__

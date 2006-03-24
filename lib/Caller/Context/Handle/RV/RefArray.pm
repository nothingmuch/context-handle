#!/usr/bin/perl

package Caller::Context::Handle::RV::RefArray;
use base qw/Caller::Context::Handle::RV::Scalar/;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $pkg = shift;
	my $code = shift;
	
	$pkg->SUPER::new(sub { \@{ uplevel 1, $code } });
}

__PACKAGE__;

__END__

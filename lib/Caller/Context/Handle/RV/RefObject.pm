#!/usr/bin/perl

package Caller::Context::Handle::RV::RefObject;

use strict;
use warnings;

sub new {
	my $self = shift;
	my $code = shift;
	my $nop = sub { $_[0] }
	$pkg->SUPER::new(sub { &{$code}->$nop });
}

__PACKAGE__;

__END__

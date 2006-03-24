#!/usr/bin/perl

package Caller::Context::Handle::RV::RefHash;

use strict;
use warnings;

sub new {
	my $self = shift;
	my $code = shift;
	$pkg->SUPER::new(sub { \%{ &$code } });
}

__PACKAGE__;

__END__

#!/usr/bin/perl

package Caller::Context::Handle::RV::RefScalar;

use strict;
use warnings;

sub new {
	my $self = shift;
	my $code = shift;
	$pkg->SUPER::new(sub { \${ &$code } });
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Caller::Context::Handle::RV::RefScalar - 

=head1 SYNOPSIS

	use Caller::Context::Handle::RV::RefScalar;

=head1 DESCRIPTION

=cut



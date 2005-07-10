#!/usr/bin/perl

package Caller::Context::Handle::RV::RefArray;
use base qw/Caller::Context::Handle::RV::Scalar/;

use strict;
use warnings;

sub new {
	my $pkg = shift;
	my  $code = shift;
	
	$pkg->SUPER::new(sub { \@{ &$code } });
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Caller::Context::Handle::RV::RefArray - 

=head1 SYNOPSIS

	use Caller::Context::Handle::RV::RefArray;

=head1 DESCRIPTION

=cut



#!/usr/bin/perl

package Caller::Context::Handle::RV::List;

use strict;
use warnings;

sub new {
	my $pkg = shift;
	my $code = shift;
	bless [ &$code ], $pkg;
}

sub value {
	my $self = shift;
	@$self;
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Caller::Context::Handle::RV::List - 

=head1 SYNOPSIS

	use Caller::Context::Handle::RV::List;

=head1 DESCRIPTION

=cut



#!/usr/bin/perl

package Caller::Context::Handle::RV::Void;

use strict;
use warnings;

sub new {
	my $pkg = shift;
	my $code = shift;
	&$code;
	bless [ ], $pkg;
}

sub value { undef }

__PACKAGE__;

__END__

=pod

=head1 NAME

Caller::Context::Handle::RV::Void - 

=head1 SYNOPSIS

	use Caller::Context::Handle::RV::Void;

=head1 DESCRIPTION

=cut



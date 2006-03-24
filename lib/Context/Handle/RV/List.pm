#!/usr/bin/perl

package Context::Handle::RV::List;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $pkg = shift;
	my $code = shift;
	bless [ uplevel 1, $code ], $pkg;
}

sub value {
	my $self = shift;
	@$self;
}

__PACKAGE__;

__END__

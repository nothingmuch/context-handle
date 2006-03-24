#!/usr/bin/perl

package Context::Handle::RV::Void;

use strict;
use warnings;

use Sub::Uplevel;

sub new {
	my $pkg = shift;
	my $code = shift;

	$code->();

	bless [ ], $pkg;
}

sub value { undef }

__PACKAGE__;

__END__

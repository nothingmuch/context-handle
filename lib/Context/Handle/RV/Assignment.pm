#!/usr/bin/perl

package Context::Handle::RV::Assignment;

use strict;
use warnings;

sub new {
	my ( $pkg, $code, $handle, @args ) = @_;
	$handle->mk_rv_container(
		sub : lvalue { $code->(@args) = $handle->assignment },
		subclass => $handle->rv_subclass_no_assignment,
	);
}

__PACKAGE__;

__END__

#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok "Context::Handle" => "context_sensitive";

use Want;

my ( $scalar, @args );
sub lvalue_scalar : lvalue {
	@args = @_;
	if ( want("LVALUE ASSIGN") ) {
		$scalar = want("ASSIGN");
		lnoreturn;
	} elsif ( want "RVALUE" ) {
		rreturn $scalar;
	} else {
		return $scalar;
	}

	return $scalar; # fake lvalue
}

sub pre_wrapped : lvalue {
	lvalue_scalar(@_);
}

my $after;
sub wrapped : lvalue {
	my @args = @_;

	my $rv = context_sensitive(\&lvalue_scalar, @args);
	$after++;

	$rv->return;
	return;
}

foreach my $code (\&lvalue_scalar, \&pre_wrapped, \&wrapped) {
	undef $scalar;

	my $rv_scalar = eval { $code->("baz") };
	ok( !$@, "no error" ) || diag $@;
	is_deeply( \@args, ["baz"], "args propagated" );
	is( $rv_scalar, undef, "rv scalar");

	eval { $code->() = "elk" };

	{
		local $TODO = "borked" if $code == \&pre_wrapped and $@;
		ok( !$@, "no error" ) || diag $@
	}

	is( $scalar, "elk", "lvalue assigned" );
	
	$rv_scalar = $code->();
	is( $rv_scalar, "elk", "rv preserved" );
}

ok( $after, "calls were wrapped" );

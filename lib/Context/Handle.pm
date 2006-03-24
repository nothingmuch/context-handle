#!/usr/bin/perl

package Context::Handle;
use base qw/Exporter/;

use strict;
use warnings;

use Want ();
use Carp qw/croak/;

use Sub::Uplevel;

use Context::Handle::RV::Scalar;
use Context::Handle::RV::Void;
use Context::Handle::RV::List;
use Context::Handle::RV::Bool;
use Context::Handle::RV::RefHash;
use Context::Handle::RV::RefArray;
use Context::Handle::RV::RefScalar;
use Context::Handle::RV::RefCode;
use Context::Handle::RV::RefObject;

BEGIN {
	our @EXPORT_OK = qw/context_sensitive/;
}

sub context_sensitive (&) {
	my $code = shift;
	__PACKAGE__->new( $code, 1 );
}

sub new {
	my $pkg = shift;
	my $code = shift;
	my $caller_level = @_ ? 1 + shift : 1;

	my $self = bless {
		uplevel => $caller_level,
		want_reftype => Want::_wantref( $caller_level + 1 ),
		want_count => Want::want_count($caller_level),
		want_wantarray => Want::wantarray_up($caller_level),
		want_bool => Want::want_boolean($caller_level),
		want_assign => [ Want::_wantassign( $caller_level + 1 ) ],
	}, $pkg;

	croak "I can't wrap around lvalues"
		if Want::want_lvalue($caller_level);

	$self->eval( $code) ;

	$self;
}

sub bool {
	my $self = shift;
	$self->{want_bool} && defined $self->{want_wantarray};
}

sub void {
	my $self = shift;
	not defined $self->{want_wantarray};
}

sub scalar {
	my $self = shift;
	defined $self->{want_wantarray} && $self->{want_wantarray} == 0;
}

sub list {
	my $self = shift;
	$self->{want_wantarray};
}

sub refarray {
	my $self = shift;
	$self->{want_reftype} eq 'ARRAY';
}

sub refhash {
	my $self = shift;
	$self->{want_reftype} eq 'HASH';
}

sub refscalar {
	my $self = shift;
	$self->{want_reftype} eq 'SCALAR';
}

sub refobject {
	my $self = shift;
	$self->{want_reftype} eq 'OBJECT';
}

sub refcode {
	my $self = shift;
	$self->{want_reftype} eq 'CODE';
}

sub refglob {
	my $self = shift;
	$self->{want_reftype} eq 'GLOB';
}


sub rv_subclass {
	my $self = shift;

	if ( $self->scalar ) {
		for (qw/RefArray RefScalar RefHash RefObject RefCode RefGlob/) {
			my $meth = lc;
			return $_ if $self->$meth;
		}

		return "Bool" if $self->bool;

		return "Scalar";
	} else {
		$self->$_ and return ucfirst for qw/void list/;
	}

	die "dunno how to do this context.";
}

sub mk_rv_container {
	my $self = shift;
	my $code = shift;

	my $subclass = $self->rv_subclass;
	"Context::Handle::RV::$subclass"->new($code);
}

sub eval {
	my $self = shift;
	my $code = shift;

	$self->{rv_container} = $self->mk_rv_container($code);
}

sub rv_container {
	my $self = shift;
	$self->{rv_container};
}

sub value {
	my $self = shift;
	$self->rv_container->value;
}

sub return {
	my $self = shift;
	Want::double_return();
	$self->value;
}


__PACKAGE__;

__END__

=pod

=head1 NAME

Context::Handle - A convenient way to link between your callers and callees.

=head1 SYNOPSIS

	use Context::Handle;

	my $h = Context::Handle->new(sub {
		$some_thing->method();
	});

=head1 DESCRIPTION

=cut



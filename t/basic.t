#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

my $m; BEGIN { use_ok($m = "Caller::Context::Handle") }

sub foo { $m->new(sub { wantarray ? "list" : "scalar" })->return }

my $scalar = foo;
is($scalar, "scalar", "scalar context");

my @list = foo;
is_deeply(\@list, ["list"], "list context");


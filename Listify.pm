package Scalar::Listify;

require 5.005_62;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Scalar::Listify ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our %EXPORT_TAGS = ( 'ALL' => [ qw(&listify
	
) ] );

Exporter::export_ok_tags('ALL');

our $VERSION = '0.01';


# Preloaded methods go here.

sub listify {
  my $sub = 'Scalar::Listify::listify';

  scalar @_ == 1 or die "$sub only takes one argument and this argument
must be a simple scalar or array reference";

  my $scalar = shift;

  !ref($scalar) and return ($scalar);

  ref($scalar) eq 'ARRAY' and return @$scalar;

  require Data::Dumper;
  my $err = "Scalar::Listify::listify error - this function only takes 
simple scalars or references to arrays. I'm not sure what you gave me, but
here is what Data::Dumper has to say about it:";
  warn $err;
  warn Data::Dumper->Dump([$scalar],['bad_data']);

}

1;
__END__

=head1 NAME

Scalar::Listify - produces an array from a scalar value or array ref.

=head1 SYNOPSIS

  use Scalar::Listify;

  $text_scalar = 'text';
  $aref_scalar = [ 1.. 5 ];

  print join ':', listify $text_scalar; # => text
  print join ':', listify $aref_scalar; # => 1:2:3:4:5

=head1 DESCRIPTION

A lot of Perl code ends up with scalars having either a single scalar
value or a reference to an array of scalar values. In order to handle
the two conditions, one must check for what is in the scalar value
before getting on with one's task. Ie:

  $text_scalar = 'text';
  $aref_scalar = [ 1.. 5 ];

  print ref($text_scalar) ? (join ':', @$text_scalar) : $text_scalar;

And this module is designed to address just that! 

=head2 EXPORT

listify() - listify takes a scalar as an argument and returns the
value of the scalar in a format useable in list contexts.


=head1 AUTHOR

T. M. Brannon, <tbone@CPAN.org>

=head1 SEE ALSO

perl(1).

=cut

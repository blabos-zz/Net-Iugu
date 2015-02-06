package Net::Iugu::Transfers;

use Moo;
extends 'Net::Iugu::Request';

sub transfer {
    my ( $self, $data ) = @_;

    my $uri = $self->endpoint;

    return $self->request( POST => $uri, $data );
}

sub list {
    my ($self) = @_;

    my $uri = $self->endpoint;

    return $self->request( GET => $uri );
}

1;

# ABSTRACT: Net::Iugu::Transfers - Methods to transfer money between accounts

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to make transfers between Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn't be instantiated direclty.

    use Net::Iugu::Transfers;

    $transfers = Net::Iugu::Transfers->new(
        token => 'my_api_token'
    );

    my $res  = $transfers->transfer( $data );
    my $list = $transfers->list;

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#transferências-de-valores>.

=method transfer( $data )

Transfer an amount of money from your account to another account.

=method list()

Return a list of all transfers previously made.

=cut


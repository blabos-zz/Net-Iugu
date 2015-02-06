package Net::Iugu::PaymentMethods;

use Moo;
extends 'Net::Iugu::CRUD';

sub create {
    my ( $self, $customer_id, $data ) = @_;

    my $uri = $self->_uri($customer_id);

    return $self->request( POST => $uri, $data );
}

sub read {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my $uri = $self->_uri( $customer_id, $payment_method_id );

    return $self->request( GET => $uri );
}

sub update {
    my ( $self, $customer_id, $payment_method_id, $data ) = @_;

    my $uri = $self->_uri( $customer_id, $payment_method_id );

    return $self->request( PUT => $uri, $data );
}

sub delete {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my $uri = $self->_uri( $customer_id, $payment_method_id );

    return $self->request( DELETE => $uri );
}

sub list {
    my ( $self, $customer_id ) = @_;

    my $uri = $self->_uri($customer_id);

    return $self->request( GET => $uri );
}

sub _uri {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my @parts = (
        $self->base_uri,       ##
        'customers',           ##
        $customer_id,          ##
        'payment_methods',     ##
        $payment_method_id,    ##
    );

    return join '/', grep { !!$_ } @parts;
}

1;

# ABSTRACT: Net::Iugu::PaymentMethods - Methods to manage payment methods

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage payment mathods of Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn't be instantiated directly.

    use Net::Iugu::PaymentMethods;

    my $methods = Net::Iugu::PaymentMethods->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $methods->create( $data );
    $res = $methods->read(   $customer_id, $method_id );
    $res = $methods->update( $customer_id, $method_id, $data );
    $res = $methods->delete( $customer_id, $method_id );
    $res = $methods->list( $params );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#formas-de-pagamento-de-cliente>.

=method create( $data )

Creates a new payment method for a client.

=method read( $customer_id, $payment_method_id )

Returns data of a payment method of a client.

=method update( $customer_id, $payment_method_id, $data )

Updates a payment method of a client.

=method delete( $customer_id, $payment_method_id )

Removes a payment method of a client.

=method list( $customer_id, $params )

Lists all payment methods of a client.

=cut


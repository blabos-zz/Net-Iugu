package Net::Iugu::PaymentMethods;

use Moo;
extends 'Net::Iugu::CRUD';

sub uri {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my @parts = (
        $self->base_uri,       ##
        'customers',           ##
        $customer_id,          ##
        'payment_methods',     ##
        $payment_method_id,    ##
    );

    return join '/', grep { defined $_ } @parts;
}

sub create {
    my ( $self, $customer_id, $data ) = @_;

    my $uri = $self->uri($customer_id);

    return $self->request( POST => $uri, $data );
}

sub read {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my $uri = $self->uri( $customer_id, $payment_method_id );

    return $self->request( GET => $uri );
}

sub update {
    my ( $self, $customer_id, $payment_method_id, $data ) = @_;

    my $uri = $self->uri( $customer_id, $payment_method_id );

    return $self->request( PUT => $uri, $data );
}

sub delete {
    my ( $self, $customer_id, $payment_method_id ) = @_;

    my $uri = $self->uri( $customer_id, $payment_method_id );

    return $self->request( DELETE => $uri );
}

sub list {
    my ( $self, $customer_id ) = @_;

    my $uri = $self->uri($customer_id);

    return $self->request( GET => $uri );
}

1;


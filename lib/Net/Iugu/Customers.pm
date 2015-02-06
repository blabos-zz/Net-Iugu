package Net::Iugu::Customers;

use Moo;
extends 'Net::Iugu::CRUD';

1;

# ABSTRACT: Net::Iugu::Customers - Methods to manage customers

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage customers of Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn't be instantiated directly.

    use Net::Iugu::Customers;

    my $customers = Net::Iugu::Customers->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $customers->create( $data );
    $res = $customers->read( $customer_id );
    $res = $customers->update( $customer_id, $data );
    $res = $customers->delete( $customer_id );
    $res = $customers->list( $params );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#clientes>.

=method create( $data )

Inherited from L<Net::Iugu::CRUD>, creates a new customer.

=method read( $customer_id )

Inherited from L<Net::Iugu::CRUD>, returns data of a customer.

=method update( $customer_id, $data )

Inherited from L<Net::Iugu::CRUD>, updates a customer.

=method delete( $customer_id )

Inherited from L<Net::Iugu::CRUD>, removes a customer.

=method list( $params )

Inherited from L<Net::Iugu::CRUD>, lists all customers.

=cut


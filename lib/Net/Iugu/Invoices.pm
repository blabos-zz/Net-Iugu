package Net::Iugu::Invoices;

use Moo;
extends 'Net::Iugu::CRUD';

sub cancel {
    my ( $self, $invoice_id ) = @_;

    my $uri = $self->endpoint . '/' . $invoice_id . '/cancel';

    return $self->request( PUT => $uri );
}

sub refund {
    my ( $self, $invoice_id ) = @_;

    my $uri = $self->endpoint . '/' . $invoice_id . '/refund';

    return $self->request( POST => $uri );
}

1;

# ABSTRACT: Net::Iugu::Invoices - Methods to manage invoices

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage invoices of Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn't be instantiated directly.

    use Net::Iugu::Invoices;

    my $invoices = Net::Iugu::Invoices->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $invoices->create( $data );
    $res = $invoices->read( $invoice_id );
    $res = $invoices->update( $invoice_id, $data );
    $res = $invoices->delete( $invoice_id );
    $res = $invoices->cancel( $invoice_id );
    $res = $invoices->refund( $invoice_id );
    $res = $invoices->list( $params );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#faturas>.

=method create( $data )

Inherited from L<Net::Iugu::CRUD>, creates a new invoice.

=method read( $invoice_id )

Inherited from L<Net::Iugu::CRUD>, returns data of an invoice.

=method update( $invoice_id, $data )

Inherited from L<Net::Iugu::CRUD>, updates an invoice.

=method delete( $invoice_id )

Inherited from L<Net::Iugu::CRUD>, removes an invoice.

=method cancel( $invoice_id )

Cancels an invoice.

=method refund( $invoice_id )

Refunds an invoice.

=method list( $params )

Lists all invoices.

=cut


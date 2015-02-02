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


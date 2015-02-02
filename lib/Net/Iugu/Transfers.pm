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


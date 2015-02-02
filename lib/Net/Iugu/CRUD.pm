package Net::Iugu::CRUD;

use Moo;
extends 'Net::Iugu::Request';

sub create {
    my ( $self, $data ) = @_;

    my $uri = $self->endpoint;

    return $self->request( POST => $uri, $data );
}

sub read {
    my ( $self, $object_id ) = @_;

    my $uri = $self->endpoint . '/' . $object_id;

    return $self->request( GET => $uri );
}

sub update {
    my ( $self, $object_id, $data ) = @_;

    my $uri = $self->endpoint . '/' . $object_id;

    return $self->request( PUT => $uri, $data );
}

sub delete {
    my ( $self, $object_id ) = @_;

    my $uri = $self->endpoint . '/' . $object_id;

    return $self->request( DELETE => $uri );
}

sub list {
    my ( $self, $params ) = @_;

    return $self->request( GET => $self->endpoint, $params );
}

1;


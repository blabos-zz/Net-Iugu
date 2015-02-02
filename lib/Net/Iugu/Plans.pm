package Net::Iugu::Plans;

use Moo;
extends 'Net::Iugu::CRUD';

sub read_by_identifier {
    my ( $self, $identifier ) = @_;

    my $uri = $self->endpoint . '/identifier/' . $identifier;

    return $self->request( GET => $uri );
}

1;


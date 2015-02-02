package Net::Iugu::Subscriptions;

use Moo;
extends 'Net::Iugu::CRUD';

sub suspend {
    my ( $self, $sub_id ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/suspend';

    return $self->request( POST => $uri );
}

sub activate {
    my ( $self, $sub_id ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/activate';

    return $self->request( POST => $uri );
}

sub change_plan {
    my ( $self, $sub_id, $plan_id ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/change_plan/' . $plan_id;

    return $self->request( POST => $uri );
}

sub add_credits {
    my ( $self, $sub_id, $quantity ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/add_credits';

    return $self->request( POST => $uri, { quantity => $quantity } );
}

sub remove_credits {
    my ( $self, $sub_id, $quantity ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/remove_credits';

    return $self->request( POST => $uri, { quantity => $quantity } );
}

1;


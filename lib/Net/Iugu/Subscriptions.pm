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

    return $self->request( PUT => $uri, { quantity => $quantity } );
}

sub remove_credits {
    my ( $self, $sub_id, $quantity ) = @_;

    my $uri = $self->endpoint . '/' . $sub_id . '/remove_credits';

    return $self->request( PUT => $uri, { quantity => $quantity } );
}

1;

# ABSTRACT: Net::Iugu::Subscriptions - Methods to manage subscriptions

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage subscriptions of Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn't be instantiated directly.

    use Net::Iugu::Subscriptions;

    my $subs = Net::Iugu::Subscriptions->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $subs->create( $data );
    $res = $subs->read( $subscription_id );
    $res = $subs->update( $subscription_id, $data );
    $res = $subs->delete( $subscription_id );
    $res = $subs->list( $params );
    $res = $subs->suspend( $subscription_id );
    $res = $subs->activate( $subscription_id );
    $res = $subs->change_plan( $subscription_id, $plan_id );
    $res = $subs->add_credits( $subscription_id, $amount );
    $res = $subs->remove_credits( $subscription_id, $amount );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#assinaturas>.

=method create( $data )

Inherited from L<Net::Iugu::CRUD>, creates a new subscription.

=method read( $subscription_id )

Inherited from L<Net::Iugu::CRUD>, returns data of a subscription.

=method update( $subscription_id, $data )

Inherited from L<Net::Iugu::CRUD>, updates a subscription.

=method delete( $subscription_id )

Inherited from L<Net::Iugu::CRUD>, removes a subscription.

=method list( $params )

Inherited from L<Net::Iugu::CRUD>, lists all subscriptions.

=method suspend( $subscription_id )

Suspends a subscription.

=method activate( $subscription_id )

Activates a subscription.

=method change_plan( $subscription_id, $plan_id )

Changes the plan of a subscrption.

=method add_credits( $subscription_id, $amount )

Adds creditis to a subscription.

=method remove_credits( $subscription_id, $amount )

Removes credits from a subscription.

=cut


package Net::Iugu::Plans;

use Moo;
extends 'Net::Iugu::CRUD';

sub read_by_identifier {
    my ( $self, $identifier ) = @_;

    my $uri = $self->endpoint . '/identifier/' . $identifier;

    return $self->request( GET => $uri );
}

1;

# ABSTRACT: Net::Iugu::Plans - Methods to manage plans

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage plans of Iugu accounts. It is used
by the main module L<Net::Iugu> and shouldn'tb e instantiated directly.

    use Net::Iugu::Plans;

    my $plans = Net::Iugu::Plans->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $plans->create( $data );
    $res = $plans->read( $plan_id );
    $res = $plans->read_by_identifier( $plan_id );
    $res = $plans->update( $plan_id, $data );
    $res = $plans->delete( $plan_id );
    $res = $plans->list( $params );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#planos>.

=method create( $data )

Inherited from L<Net::Iugu::CRUD>, creates a new plan.

=method read( $plan_id )

Inherited from L<Net::Iugu::CRUD>, returns data of a plan.

=method read_by_identifier( $identifier_id )

Returns data of a plan using an identifier ID.

=method update( $plan_id, $data )

Inherited from L<Net::Iugu::CRUD>, updates a plan.

=method delete( $plan_id )

Inherited from L<Net::Iugu::CRUD>, removes a plan.

=method list( $params )

Inherited from L<Net::Iugu::CRUD>, lists all plans.

=cut


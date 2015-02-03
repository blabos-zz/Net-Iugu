package Net::Iugu;

use Moo;
extends 'Net::Iugu::Request';

use Net::Iugu::Customers;
use Net::Iugu::PaymentMethods;
use Net::Iugu::Invoices;
use Net::Iugu::MarketPlace;
use Net::Iugu::Plans;
use Net::Iugu::Subscriptions;
use Net::Iugu::Transfers;

has 'token' => (
    is       => 'ro',
    required => 1,
);

has 'customers' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::Customers->new( token => shift->token ) },
);

has 'payment_methods' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::PaymentMethods->new( token => shift->token ) },
);

has 'invoices' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::Invoices->new( token => shift->token ) },
);

has 'market_place' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::MarketPlace->new( token => shift->token ) },
);

has 'plans' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::Plans->new( token => shift->token ) },
);

has 'subscriptions' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::Subscriptions->new( token => shift->token ) },
);

has 'transfers' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { Net::Iugu::Transfers->new( token => shift->token ) },
);

sub create_token {
    my ( $self, $data ) = @_;

    my $uri = $self->base_uri . '/payment_token';

    return $self->request( POST => $uri, $data );
}

sub charge {
    my ( $self, $data ) = @_;

    my $uri = $self->base_uri . '/charge';

    return $self->request( POST => $uri, $data );
}

1;

# ABSTRACT: Perl modules for integration with Iugu payment web services


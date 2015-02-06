package Net::Iugu::Request;

use Moo;

use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Request;

use JSON qw{ from_json to_json };
use MIME::Base64 qw{ encode_base64 };
use String::CamelCase qw{ decamelize };

has 'base_uri' => (
    is      => 'ro',
    builder => sub { 'https://api.iugu.com/v1' },
);

has 'object' => (
    is      => 'rw',
    default => sub {
        my $pkg = ref shift;
        my @parts = split /::/, $pkg;

        return decamelize $parts[-1];
    },
);

has 'token' => (
    is       => 'rw',
    required => 1,
);

has 'endpoint' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub {
        my ($self) = @_;

        return $self->base_uri . '/' . $self->object;
    },
);

has 'ua' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub { LWP::UserAgent->new },
);

has 'headers' => (
    is      => 'ro',
    lazy    => 1,
    builder => sub {
        my ($self) = @_;

        my $auth = 'Basic ' . encode_base64( $self->token . ':', '' );

        return HTTP::Headers->new(
            'Authorization' => $auth,
            'Content-Type'  => 'application/json',
        );
    },
);

sub request {
    my ( $self, $method, $uri, $data ) = @_;

    my $content = $data ? to_json $data : undef;

    my $req = HTTP::Request->new(
        $method => $uri,
        $self->headers,
        $content,
    );

    my $res = $self->ua->request($req);

    return from_json $res->content;
}

1;

# ABSTRACT: Net::Iugu::Request - General HTTP requests to Iugu API

=pod

=encoding utf8

=head1 SYNOPSIS

Encapsulates HTTP requests to Iugu API to properly set the headers,
encode the data sent and decode the data received.

It is used as base class for other modules and shouldn't be instantiated
direclty.

    package Net::Iugu::Endpoint;

    use Moo;
    extends 'Net::Iugu::Request';

    ...

    package main;

    use Net::Iugu::Endpoint;

    my $endpoint = Net::Iugu::Endpoint->new(
        token => 'my_api_token'
    );

    my $res = $endpoint->request( $method, $uri, $data );

=method request( $method, $uri, $data )

Encodes the C<$data> as JSON and send it to C<$uri> via C<$method> HTTP
method.

The data is received from the webservice as JSON but are inflated to Perl
data structures before it returns.

=cut


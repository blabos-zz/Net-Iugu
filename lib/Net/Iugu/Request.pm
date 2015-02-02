package Net::Iugu::Request;

use Moo;

use JSON;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Request;

use MIME::Base64 qw{ encode_base64 };
use String::CamelCase qw{ decamelize };

has 'base_uri' => (
    is      => 'ro',
    builder => sub { 'https://api.iugu.com/v1' },
);

has 'object' => (
    is      => 'rw',
    default => sub { decamelize '' . ( split /::/, ref shift )[-1] },
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

        my $endpoint = $self->base_uri;
        $endpoint .= '/' . $self->object
          if $self->object;

        return $endpoint;
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

        my $auth = 'Basic ' . encode_base64( $self->token . ':' );

        return HTTP::Headers->new(
            'Authorization' => $auth,
            'Content-Type'  => 'application/json',
        );
    }
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


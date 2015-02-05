package Net::Iugu::MarketPlace;

use Moo;
extends 'Net::Iugu::Request';

use JSON;
use HTTP::Headers;
use HTTP::Request;

use File::Slurp qw{ read_file };
use MIME::Base64 qw{ encode_base64 };

sub create_account {
    my ( $self, $data ) = @_;

    my $uri = $self->base_uri . '/marketplace/create_account';

    return $self->request( POST => $uri, $data );
}

sub request_account_verification {
    my ( $self, $user_token, $account_id, $data ) = @_;

    my @parts = (
        $self->base_uri,           ##
        'accounts',                ##
        $account_id,               ##
        'request_verification',    ##
    );

    my $uri = join '/', @parts;

    if ( exists $data->{files} ) {
        foreach my $key ( keys %{ $data->{files} } ) {
            my $path    = $data->{files}{$key};
            my $bytes   = read_file( $path, { binmode => ':raw' } );
            my $encoded = encode_base64( $bytes, '' );

            $data->{files}{$key} = $encoded;
        }
    }

    my $auth = 'Basic ' . encode_base64( $user_token . ':', '' );
    my $headers = HTTP::Headers->new(
        'Authorization' => $auth,
        'Content-Type'  => 'application/json',
    );

    my $content = to_json $data;
    my $req     = HTTP::Request->new(
        POST => $uri,
        $headers,
        $content,
    );

    my $res = $self->ua->request($req);

    warn ">>>> " . $res->code;

    return $res->content;
}

sub account_info {
    my ( $self, $account_id ) = @_;

    my $uri = $self->base_uri . '/accounts/' . $account_id;

    return $self->request( GET => $uri );
}

sub configurate_account {
    my ( $self, $data ) = @_;

    my $uri = $self->base_uri . '/accounts/configuration';

    return $self->request( POST => $uri, $data );
}

sub request_withdraw {
    my ( $self, $account_id, $amount ) = @_;

    my @parts = (
        $self->base_uri,       ##
        'accounts',            ##
        $account_id,           ##
        'request_withdraw',    ##
    );

    my $uri = join '/', @parts;

    return $self->request( POST => $uri, { amount => $amount } );
}

1;


package Net::Iugu::MarketPlace;

use Moo;
extends 'Net::Iugu::Request';

use HTTP::Headers;
use HTTP::Request;
use File::LibMagic;

use JSON qw{ from_json to_json };
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
            my $info    = File::LibMagic->new->info_from_filename($path);

            my $mime =
                $info->{mime_type} =~ m#(image/.+?;)#
              ? $1
              : 'image/jpeg;';

            $data->{files}{$key} = 'data:' . $mime . 'base64,' . $encoded;
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

    return from_json $res->content;
}

sub account_info {
    my ( $self, $account_id ) = @_;

    my $uri = $self->base_uri . '/accounts/' . $account_id;

    return $self->request( GET => $uri );
}

sub configurate_account {
    my ( $self, $user_token, $data ) = @_;

    my $uri = $self->base_uri . '/accounts/configuration';

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

    return from_json $res->content;
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

# ABSTRACT: Net::Iugu::MarketPlace - Methods to manage marketplaces

=pod

=encoding utf8

=head1 SYNOPSIS

Implements the API calls to manage marketplaces. It is used by the main
module L<Net::Iugu> and shouldn't be instantiated directly.

    use Net::Iugu::MarketPlaces;

    my $mp = Net::Iugu::MarketPlaces->new(
        token => 'my_api_token'
    );

    my $res;

    $res = $mp->create_account( $data );
    $res = $mp->request_account_verification( $user_token, $account_id, $data );
    $res = $mp->account_info( $account_id );
    $res = $mp->configurate_account( $user_token, $data );
    $res = $mp->request_withdraw( $account_id, $amount );

For a detailed reference of params and return values check the
L<Official Documentation|http://iugu.com/referencias/api#marketplace>.

=method create_account( $data )

Creates a sub account.

=method request_account_verification( $user_token, $account_id, $data )

Requests a verification of the account C<$account_id>. Note thath you must
specify the C<$user_token> of this account.

=method account_info( $account_id )

Return info about this account.

=method configurate_account( $user_token, $data )

(Re-)Configurates the account related to C<$user_token>.

=method request_withdraw( $account_id, $amount )

Requests a withdraw of an amount C<$amount> from the account C<$account_id>.

=cut


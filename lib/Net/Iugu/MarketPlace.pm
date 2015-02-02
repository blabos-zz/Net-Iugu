package Net::Iugu::MarketPlace;

use Moo;
extends 'Net::Iugu::Request';

sub create_account {
    my ( $self, $data ) = @_;

    my $uri = $self->base_uri . '/marketplace/create_account';

    return $self->request( POST => $uri, $data );
}

sub request_account_verification {
    my ( $self, $account_id, $data ) = @_;

    my @parts = (
        $self->base_uri,           ##
        'accounts',                ##
        $account_id,               ##
        'request_verification',    ##
    );

    my $uri = join '/', @parts;

    return $self->request( POST => $uri, $data );
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


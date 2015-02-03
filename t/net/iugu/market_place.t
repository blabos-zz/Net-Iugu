#!perl

use Test::Most;
use Net::Iugu;

use lib 't/lib';
use MyTest qw{ check_endpoint };

## Setup
my $api = Net::Iugu->new( token => '1234567890' );

my @tests = (
    {
        name   => 'create_account',
        args   => [ { name => 'Subconta', commission_percent => 10 } ],
        method => 'POST',
        uri    => 'https://api.iugu.com/v1/marketplace/create_account',
    },
    {
        name   => 'account_info',
        args   => ['111'],
        method => 'GET',
        uri    => 'https://api.iugu.com/v1/accounts/111',
    },
    {
        name   => 'configurate_account',
        args   => [ { commission_percent => 10 } ],
        method => 'POST',
        uri    => 'https://api.iugu.com/v1/accounts/configuration',
    },
    {
        name   => 'request_withdraw',
        args   => [ '555', '123.45', { amount => '123.45' } ],
        method => 'POST',
        uri    => 'https://api.iugu.com/v1/accounts/555/request_withdraw',
    },
);

check_endpoint( $api->market_place, @tests );

done_testing;

##############################################################################


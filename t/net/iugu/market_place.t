#!perl

use Test::Most;
use Net::Iugu;

use lib 't/lib';
use MyTest qw{ check_endpoint };

## Setup
my $api = Net::Iugu->new( token => '1234567890' );

#my @tests = (
#    {
#        name   => 'create_account',
#        args   => [ { name => 'Subconta', commission_percent => 10 } ],
#        method => 'POST',
#        uri    => 'https://api.iugu.com/v1/marketplace/create_account',
#    },
#    {
#        name   => 'account_info',
#        args   => ['111'],
#        method => 'GET',
#        uri    => 'https://api.iugu.com/v1/accounts/111',
#    },
#    {
#        name   => 'configurate_account',
#        args   => [ { commission_percent => 10 } ],
#        method => 'POST',
#        uri    => 'https://api.iugu.com/v1/accounts/configuration',
#    },
#    {
#        name   => 'request_withdraw',
#        args   => [ '555', '123.45', { amount => '123.45' } ],
#        method => 'POST',
#        uri    => 'https://api.iugu.com/v1/accounts/555/request_withdraw',
#    },
#);
#
#check_endpoint( $api->market_place, @tests );

$api = Net::Iugu->new( token => '5a328004c7dd4ccc4ad0a93523d1ad07:' );
my $res = $api->market_place->request_account_verification(
    '3fde194676dcb183da972d3d5529f5cc',
    '695E16664DD549C7A523A817DCF03449',
    {
        data => {
            price_range        => 'Até R$ 100,00',
            physical_products  => 'false',
            business_type      => 'Serviços de Limpeza',
            person_type        => 'Pessoa Física',
            automatic_transfer => 'false',
            cpf                => '123.123.123-12',
            name               => 'Nome da Pessoa',
            address            => 'Av. Paulista 320 cj 10',
            cep                => '01419-000',
            city               => 'São Paulo',
            state              => 'São Paulo',
            telephone          => '11-91231-1234',
            bank               => 'Itaú',
            bank_ag            => '1234',
            account_type       => 'Corrente',
            bank_cc            => '11231-2',
        },
        files => {
            id       => 'white.jpg',    ## 10x10 white jpg
            activity => 'red.jpg',      ## 10x10 red jpg
        },
    },
);

use Data::Dumper;
warn Dumper $res;

done_testing;

##############################################################################


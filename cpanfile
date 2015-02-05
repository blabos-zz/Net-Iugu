requires 'Moo'               => '1.007000';
requires 'LWP::UserAgent'    => '6.06';
requires 'HTTP::Message'     => '6.06';
requires 'MIME::Base64'      => '3.15';
requires 'String::CamelCase' => '0.02';
requires 'File::Slurp'       => '9999.19';

on 'test' => sub {
    requires 'Test::Most'    => '0.34';
    requires 'Sub::Override' => '0.09';
};


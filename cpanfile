requires 'Moo'               => '1.007000';
requires 'JSON'              => '2.90';
requires 'LWP::UserAgent'    => '6.06';
requires 'HTTP::Message'     => '6.06';
requires 'MIME::Base64'      => '3.15';
requires 'String::CamelCase' => '0.02';
requires 'File::Slurp'       => '9999.19';
requires 'File::LibMagic'    => '1.10';

on 'test' => sub {
    requires 'Test::Most'    => '0.34';
    requires 'Sub::Override' => '0.09';
};

on 'develop' => sub {
    requires 'Test::Pod'               => '1.48';
    requires 'Test::Pod::Coverage'     => '1.10';
    requires 'Pod::Coverage::TrustPod' => '0.100003';
};

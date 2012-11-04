package Inventory::Routes::Account;

use Dancer ':syntax';

use Inventory::Authorise::Web;

use strict;

prefix	'/account';

post    '/create'	=> \&create_account;

sub create_account {
    my @allowed_fields = qw /
        email
        password
    /;
    
    my $values;
    
    foreach my $value ( @allowed_fields ) {
        $values->{ $value } = param $value;
    }
    
	my $account = Inventory::Authorise::Web->new();
    my $created = $account->create_user( $values->{ email }, $values->{ password } );
    
    return $created;
};

1;
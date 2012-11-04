package Inventory::Routes::Account;

use Dancer ':syntax';

use Inventory::Accounts::Admin;
use Inventory::Authorise::Web;

use strict;

prefix	'/account';

post    '/create'	=> \&create_account;
get     '/created'  => \&account_created;

sub account_created {
    template 'Accounts/Created', {}, { layout => 0 };
};

sub create_account {
    my @allowed_fields = qw /
        username
        password
    /;
    
    my $values;
    
    foreach my $value ( @allowed_fields ) {
        $values->{ $value } = param $value;
    }
    
	my $account = Inventory::Accounts::Admin->new();
    my $created = $account->create_user( $values->{ username }, $values->{ password } );
    
    forward '/created';
};

1;
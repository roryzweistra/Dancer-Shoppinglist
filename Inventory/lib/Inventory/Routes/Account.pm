package Inventory::Routes::Account;

use Dancer ':syntax';

use Inventory::Accounts::Admin;
use Inventory::Authorise::Web;

use strict;

prefix	'/account';

get     '/authorised'   => \&authorised;
post    '/create'	    => \&create_account;
get     '/created'      => \&account_created;
post    '/login'        => \&login_account;

sub account_created {
    template 'Accounts/Created', {}, { layout => 0 };
};

sub authorised {
    redirect '/inventories';
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

sub login_account {
    my @allowed_fields = qw /
        username
        password
    /;
    
    my $values;
    
    foreach my $value ( @allowed_fields ) {
        $values->{ $value } = param $value;
    }
    
    my $account     = Inventory::Authorise::Web->new();
    my $logged_in   = $account->check_login( $values->{ username }, $values->{ password } );
    info 'logged_in: ' . session('logged_in');
    
    if ( $logged_in == 100 ) {
        forward '/account/authorised', {}, { method => 'GET' };
    }
};

1;
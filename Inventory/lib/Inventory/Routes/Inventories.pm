package Inventory::Routes::Inventories;

use Dancer ':syntax';

use Inventory::Inventories::List;
use Inventory::Inventories::Inventory;

use strict;

prefix	'/inventories';

get	    '/new'	    => \&new_inventory;
post    '/create'   => \&create_inventory;
get     '/list'	    => \&list_inventories;

sub new_inventory {
	template 'Inventories/New', {}, { layout => 0 };
};

sub create_inventory {
    my $name    = param 'inventory_name';
    my $user_id = session( 'user_id' );
    info 'userid: ' . $user_id;
    
    my $inventory   = Inventory::Inventories::Inventory->new();
    my $created     = $inventory->create( session( 'user_id' ), $name );
    
    return $created;
};

sub list_inventories {
    my $user_id     = session( 'user_id' );
	my $list 	    = Inventory::Inventories::List->new();
	my $inventories = $list->list_inventories( $user_id );
    info $inventories;
	return $inventories;
};

1;
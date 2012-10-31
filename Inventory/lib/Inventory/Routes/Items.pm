package Inventory::Routes::Items;

use Dancer ':syntax';

use Inventory::Items::List;
use Inventory::Items::Item;

use strict;

get 	'/items'	=> \&list_items;
post	'/item/add'	=> \&add_item;

sub add_item {

	# Create a list of parameters that are allowed for this request.
	my @allowed_fields	= qw /
		name
	/;

	my $values 		= {};

        foreach my $allowed ( @allowed_fields ) {
                $values->{ $allowed } = param $allowed;
        }

	# Instanciate item object.
	my $item		= Inventory::Items::Item->new();

	return $item->add( $values->{ name } );
};

sub list_items {

	my $list 	= Inventory::Items::List->new();
	my $items	= $list->list_items();

	template 'Items/list_items' => $items;
};

1;

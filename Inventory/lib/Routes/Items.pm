package Inventory::Routes::Items;

use Dancer ':syntax';
use Dancer::Plugin::REST;

use Inventory::Items::List;
use Inventory::Items::Item;

use strict;

prepare_serializer_for_format;

get '/items/:format?'	=> \&list_items;

sub list_items {

	my $list 	= Inventory::Items::List->new();
	my $items	= $list->list_items();

	if ( params->{ format } ) {
		return $items;
	}

	template 'items' => $items;
};

resource item 	=> 
	get	=> \&get_item, 
	create	=> \&add_item, 
	update	=> \&update_item, 
	delete	=> \&delete_item; 

package Inventory::Items::Navigation;

use Dancer ':syntax';
use Dancer::Plugin::REST;

use strict;

prepare_serializer_for_format;

get '/items'	=> \&list_items;

resource item 	=> 
	get	=> \&get_item, 
	create	=> \&add_item, 
	update	=> \&update_item, 
	delete	=> \&delete_item; 

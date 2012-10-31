package Inventory::Routes::Items;

use Dancer ':syntax';

use Inventory::Items::List;

use strict;

prefix	'/items';

get 	'/list'	=> \&list;

sub list {

	my $list 	= Inventory::Items::List->new();
	my $items	= $list->list_items();

	template 'Items/List' => $items;
};

1;

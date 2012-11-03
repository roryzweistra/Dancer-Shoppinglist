package Inventory::Routes::Inventories;

use Dancer ':syntax';

use Inventory::Inventories::List;

use strict;

prefix	'/inventories';

get	'/new'	=> \&new;
get 	'/list'	=> \&list;

sub new {
	template 'Inventories/New';
};

sub list {

	my $list 	= Inventory::Inventories::List->new();
	my $items	= $list->list_items();

	template 'Inventories/List' => $items;
};

1;

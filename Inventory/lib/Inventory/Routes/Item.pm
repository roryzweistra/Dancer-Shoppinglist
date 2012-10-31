package Inventory::Routes::Item;

use Dancer ':syntax';

use Inventory::Items::Item;

use strict;

# Prefix the urls
prefix	'/item';

get	'/new'		=> \&new_item;
post	'/create'	=> \&create_item;

sub create_item {

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

	return $item->create( $values->{ name } );
};


sub new_item {
	template 'Item/New';
};

1;

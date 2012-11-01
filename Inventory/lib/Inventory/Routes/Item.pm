package Inventory::Routes::Item;

use Dancer ':syntax';

use Inventory::Items::Item;

use strict;

# Prefix the urls
prefix	'/item';

get	'/new'		=> \&new_item;
get	'/id/:id'	=> \&get_item;
post	'/create'	=> \&create_item;
put	'/update'	=> \&update_item;

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


sub get_item {
	my $guid = param 'id';

	return $guid;
	
}

sub new_item {
	template 'Item/New';
};

sub update_item {
	
	my @allowed_fields	= qw /
		guid
		name
	/;

	my $values = {};

	foreach my $allowed ( @allowed_fields ) {
		$values->{ $allowed } = param $allowed;	
	}

	my $item	= Inventory::Items::Item->new();
	my $updated	= $item->create( $values );
	
	return $updated;
};

1;

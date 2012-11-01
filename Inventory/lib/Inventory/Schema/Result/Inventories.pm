package Inventory::Schema::Result::Inventories;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table(		'Inventories'  );

# Table columns
__PACKAGE__->add_columns(	qw /
                                	guid
                                    	owner
					name
                                /
);

# Primary key of the table
__PACKAGE__->set_primary_key(	'guid'    );

# Add relationships for this table
__PACKAGE__->belongs_to(	'users'			=> 'Inventory::Schema::Result::Users', {
	'foreign.guid' 		=> 'self.owner'
});

__PACKAGE__->has_many(		'inventory_items'	=> 'Inventory::Schema::Result::Inventory_items', {
	'foreign.inventory'	=> 'self.guid'
});

1;

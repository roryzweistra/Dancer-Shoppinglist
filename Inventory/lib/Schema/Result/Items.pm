package Inventory::Schema::Result::Items;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table(		'items'  );

# Table columns
__PACKAGE__->add_columns(	qw/
                                	guid
                                    	name
					identifier
                                /
);

# Primary key of the table
__PACKAGE__->set_primary_key(	'guid'    );

# Add relationships for this table

1;

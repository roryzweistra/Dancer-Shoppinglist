package Inventory::Schema::Result::Categories;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table(		'categories'  );

# Table columns
__PACKAGE__->add_columns(	qw /
                                	guid
                                    	name
                                /
);

# Primary key of the table
__PACKAGE__->set_primary_key(	'guid'    );

# Add relationships for this table

1;

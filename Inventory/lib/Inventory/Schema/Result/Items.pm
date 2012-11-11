package Inventory::Schema::Result::Items;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table(		'Items'  );

# Table columns
__PACKAGE__->add_columns(	qw /
        guid
        name
        packaging
        unit
        content
    /
);

# Primary key of the table
__PACKAGE__->set_primary_key(	'guid'    );

# Add relationships for this table

1;
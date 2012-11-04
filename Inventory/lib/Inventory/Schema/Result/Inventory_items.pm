package Inventory::Schema::Result::Inventory_items;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table( 'Inventory_items'  );

# Table columns
__PACKAGE__->add_columns(   qw /
        guid
        inventory
        item
        amount
    /
);

# Primary key of the table
__PACKAGE__->set_primary_key(   'guid'    );

# Add relationships for this table
__PACKAGE__->belongs_to(    'inventories'   => 'Inventory::Schema::Result::Inventories', {
    'foreign.guid'  => 'self.inventory'
});

1;

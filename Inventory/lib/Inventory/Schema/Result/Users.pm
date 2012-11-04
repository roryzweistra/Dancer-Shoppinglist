package Inventory::Schema::Result::Users;
use base qw/ DBIx::Class::Core /;

# Table name
__PACKAGE__->table(     'Users'  );

# Table columns
__PACKAGE__->add_columns(   qw /
        guid
        username
        password
    /
);

# Primary key of the table
__PACKAGE__->set_primary_key(   'guid'    );

# Add relationships for this table
__PACKAGE__->has_many(      'inventories'   => 'Inventory::Schema::Result::Inventories', {
    'foreign.owner' => 'self.guid'
});

1;

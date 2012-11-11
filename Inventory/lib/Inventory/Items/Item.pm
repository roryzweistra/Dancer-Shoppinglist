package Inventory::Items::Item;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Inventory::Utils;

sub create {
	my $self	= shift;
    my $values  = shift;
	my $guid	= Inventory::Utils->new->create_guid();
	my $item	= schema( 'Inventory' )->resultset( 'Items' )->update_or_new(
        {
			guid	    => $guid,
			name	    => $values->{ name      },
            content     => $values->{ content   },
            unit        => $values->{ unit      },
            packaging   => $values->{ packaging }
        },
		{
			key => 'primary'
		}
	);

	$item->insert();
    
    return 300 unless $item->in_storage();
    
    if ( $values->{ add_to_inventory } ) {
        $inventory_item = schema( 'Inventory' )->resultset( 'Inventory_items' )->new(
            {
                guid        => Inventory::Utils->new->create_guid(),
                item        => $guid,
                inventory   => $values->{ inventory }
            },
            {
                key => 'primary'
            }
        );
        
        $inventory_item->insert();
    }
    
    
    return 301 if $item->in_storage();
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;
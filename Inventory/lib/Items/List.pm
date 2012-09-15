package Inventory::Items::List;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

sub list_items {
	my $self	= shift;
	my @results	= schema( 'inventory' )->resultset( 'Items' )->all();

	my @items;

	foreach my $item ( @results ) {
		push ( @items, {
			guid		=> $item->{ guid 	},
			name		=> $item->{ name	},
			identifier	=> $item->{ identifier	}
		});
	}

	return \@items;
}

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
}

1;

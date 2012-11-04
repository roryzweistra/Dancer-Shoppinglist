package Inventory::Inventories::List;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

sub list_inventories {
	my $self	= shift;
	my @results	= schema( 'Inventory' )->resultset( 'Inventories' )->all();

	my @items;

	foreach my $item ( @results ) {
		push ( @items, {
			guid	=> $item->{ guid 	},
			name    => $item->{ name	},
		});
	}

	my @items;
	return @items;
	#return \@items;
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;

package Inventory::Categories::List;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

sub list_categories {
	my $self	= shift;
	my @results	= schema( 'inventory' )->resultset( 'Categories' )->all();

	my @categories;

	foreach my $category ( @categories ) {
		push ( @items, {
			guid		=> $category->{ guid 	},
			name		=> $category->{ name	},
		});
	}

	return \@categories;
}

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
}

1;

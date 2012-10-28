package Inventory::Items::Item;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

sub create {
	my $self	= shift;
	my $name	= shift;
	my $guid	= 1;

	my $item	= schema( 'inventory' )->resultset( 'Items' )->update_or_new(
			$guid,
			$name, 
		{
			key => 'primary'
		}
	);

	$item->insert();

	return $poi->in_storage();
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;

package Inventory::Items::Item;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Data::GUID::URLSafe;

sub create {
	print "in create\n";
	my $self	= shift;
	my $name	= shift;
	my $guid	= Data::GUID->new->as_base64_urlsafe;
	my $item	= schema( 'Inventory' )->resultset( 'Items' )->update_or_new(
			guid	=> $guid,
			name	=> $name, 
		{
			key => 'primary'
		}
	);

	$item->insert();

	return $item->in_storage();
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;

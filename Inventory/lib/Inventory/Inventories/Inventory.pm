package Inventory::Inventories::Inventory;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Data::GUID::URLSafe;

sub create {
	my $self	    = shift;
    my $user        = shift;
	my $name	    = shift;
	my $guid	    = Data::GUID->new->as_base64_urlsafe;
	my $inventory   = schema( 'Inventory' )->resultset( 'Inventories' )->new(
        {
			guid	=> $guid,
            owner   => $user,
			name	=> $name,
        },
		{
			key => 'primary'
		}
	);

	$inventory->insert();

	return $inventory->in_storage();
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;

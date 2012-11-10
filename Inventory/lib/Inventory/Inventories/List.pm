package Inventory::Inventories::List;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

sub list_inventories {
	my $self	= shift;
    my $user_id = shift;
    
	my @results	= schema( 'Inventory' )->resultset( 'Inventories' )->search(
        {
            owner   => $user_id
        },
        {
            columns => [ qw /
                guid
                name
            / ]
        }
    );
    info 'results: ' . @results;
	my @inventories;

	foreach my $inventory ( @results ) {
        info 'result: ' . $inventory;
		push ( @inventories, {
			guid	=> $inventory->guid,
			name    => $inventory->name,
		});
	}

    return \@inventories;
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;

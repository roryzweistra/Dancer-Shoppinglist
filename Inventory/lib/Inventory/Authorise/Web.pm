package Inventory::Authorise::Web;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Crypt::SaltedHash;

sub check_login {
    my $self        = shift;
    my $email       = shift;
    my $password    = shift;

    my $user        = schema( 'inventory' )->resultset( 'Users' )->find(
        {
            username    => $email
        }
    );

    return 0 unless $user;

    my $csh		= Crypt::SaltedHash->new();
	my $valid	= $csh->validate( $user->password, $password );
};

sub create_user {
	my $self	= shift;
	my $email	= shift;
	
	return 'exists' if schema( 'inventory' )->resultset( 'Users' )->find(
		{
            username    => $email
		}
	);

	my $password    = shift;
	my $csh	        = Crypt::SaltedHash->new( algorithm => 'sha256' );
	$csh->add( $password );

	my $new_user	= schema( 'inventory' )->resultset( 'Users' )->create(
		{
			username    => $email,
			password	=> $csh->generate(),
		}
	);

	return $new_user->in_storage;	
};

sub new {
	my $class   = shift;
	my $self	= bless {}, $class;

	return $self;
};

1;
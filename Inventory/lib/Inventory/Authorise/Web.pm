package Inventory::Authorise::Web;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Crypt::SaltedHash;
use Data::GUID::URLSafe;

sub check_login {
    my $self        = shift;
    my $email       = shift;
    my $password    = shift;

    my $user        = schema( 'Inventory' )->resultset( 'Users' )->find(
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
	
	return 'exists' if schema( 'Inventory' )->resultset( 'Users' )->find(
		{
            username    => $email
		}
	);

    my $guid    = Data::GUID->new->as_base64_urlsafe;

	my $password    = shift;
	my $csh	        = Crypt::SaltedHash->new();
	$csh->add( $password );

	my $new_user	= schema( 'Inventory' )->resultset( 'Users' )->create(
		{
            guid        => $guid,
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
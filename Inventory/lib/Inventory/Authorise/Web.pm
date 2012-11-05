package Inventory::Authorise::Web;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Crypt::SaltedHash;
use Data::GUID::URLSafe;

sub check_login {
    my $self        = shift;
    
    my $email       = shift;
    return 101 unless $email;
    
    my $password    = shift;
    return 102 unless $password;

    my $user        = schema( 'Inventory' )->resultset( 'Users' )->find(
        {
            username    => $email
        }
    );

    return 103 unless $user;

    my $csh		= Crypt::SaltedHash->new();
	my $valid	= $csh->validate( $user->password, $password );
    return 104 unless $valid;
    
    session logged_in => 1;
    session user      => $email;
    return 100;
};

sub new {
	my $class   = shift;
	my $self	= bless {}, $class;

	return $self;
};

1;
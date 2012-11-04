package Inventory::Accounts::Admin;

use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

use Crypt::SaltedHash;
use Data::GUID::URLSafe;

sub create_user {
	my $self	= shift;
    
    # Get the passed in email or return an error if not.
	my $email	= shift;
	return 201 unless $email;
    
    # Check if the email address already exists in the user table. If so, return an error.
	return 203 if schema( 'Inventory' )->resultset( 'Users' )->find(
		{
            username    => $email
		}
	);

    # Get the passed in password or return an error if not.
	my $password    = shift;
    return 202 unless $password;
    
    # Create an URL safe guid.
    my $guid    = Data::GUID->new->as_base64_urlsafe;

    # Setup a nice crypted password.    
	my $csh     = Crypt::SaltedHash->new();
	$csh->add( $password );

    # All conditions have been met, setup the INSERT statement.
	my $new_user	= schema( 'Inventory' )->resultset( 'Users' )->create(
		{
            guid        => $guid,
			username    => $email,
			password	=> $csh->generate(), # Hash & Salt the password.
		}
	);
    
    # Try to execute the INSERT statement, return an error if fails.
	return 204 unless $new_user->in_storage;

    # We're all set, setup session values.
    return 200;
};

sub new {
	my $class   = shift;
	my $self	= bless {}, $class;

	return $self;
};

1;
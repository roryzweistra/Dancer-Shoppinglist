package	Inventory::Utils;

use Data::GUID::URLSafe;
use Dancer::Plugin::Locale::Wolowitz;

use strict;
use warnings;

sub create_guid {
	return Data::GUID->new->as_base64_urlsafe;
};

sub create_status {
    my $self    = shift;
    my $code    = shift;
    my $options = shift;

    my $status;
    $status->{ code }   = loc( 'status_code_' . $code );
    $status->{ text }   = loc( 'status_text_' . $code );
    $status->{ type }   = loc( 'status_type_' . $code );

    return $status;
};

sub new {
	my $class	= shift;
	my $self	= bless {}, $class;

	return $self;
};

1;
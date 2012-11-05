package Inventory;
use Dancer ':syntax';

our $VERSION = '0.1';

hook before_template => sub {
  my $tokens                = shift;
  $tokens->{ logged_in  }   = session('logged_in');
  $tokens->{ user       }   = session('user');
};

get '/' 		    => sub {
	template 'index';
};

get '/inventories'  => sub {
	#template 'inventories', { session => session };
    info session;
	template 'inventories';
};

get '/profile'		=> sub {
	template 'profile';
};

get '/login'		=> sub {
	template 'login';
};

get '/logout'       => sub {
    info session;
    session->destroy;
    forward '/';
};

get '/register'		=> sub {
	template 'Accounts/Register', {}, { layout => 0 };
};

load_app 'Inventory::Routes::Account';
load_app 'Inventory::Routes::Items';
load_app 'Inventory::Routes::Item';
load_app 'Inventory::Routes::Inventories';

true;

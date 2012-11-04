package Inventory;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' 		    => sub {
	template 'index';
};

get '/inventories'  => sub {
	template 'inventories';
};

get '/profile'		=> sub {
	template 'profile';
};

get '/login'		=> sub {
	template 'login';
};

get '/register'		=> sub {
	template 'register', {}, { layout => 0 };
};

post '/account/create'	=> sub {
	return 1;
};

load_app 'Inventory::Routes::Items';
load_app 'Inventory::Routes::Item';
load_app 'Inventory::Routes::Inventories';

true;
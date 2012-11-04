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
	template 'Accounts/Register', {}, { layout => 0 };
};

load_app 'Inventory::Routes::Account';
load_app 'Inventory::Routes::Items';
load_app 'Inventory::Routes::Item';
load_app 'Inventory::Routes::Inventories';

true;

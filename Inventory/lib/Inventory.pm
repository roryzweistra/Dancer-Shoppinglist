package Inventory;
use Dancer ':syntax';

use Inventory::Routes::Items;
use Inventory::Routes::Item;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

true;

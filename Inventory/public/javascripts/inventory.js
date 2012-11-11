$( document ).ready( function() {
	init_pjax();
	wire_create_inventory_form();
	wire_register_form_button();
	wire_register_account_button();
    wire_inventory_list();
    populate_inventory_table();
    wire_search_inventory_item();
    wire_inventory_controls_button();
    wire_create_new_item_button();
});

var init_pjax = function() {
    $( 'a.pjax' ).pjax( '#main', {
        fragment: '#pjax'
    });

    $( '#main' )
    .bind( 'pjax:start', function() {
    console.log( 'pjax call' );
            //$( '#main'      ).fadeOut('slow');
        //$( '#loader'    ).show();
    })
    .bind( 'pjax:end', function() {

        //$( '#loader'    ).hide();    
        $( '#main'      ).fadeIn('slow');
        wire_create_inventory_form();
        wire_register_form_button();
        wire_register_account_button();
        wire_inventory_list;
        populate_inventory_table();
        wire_search_inventory_item();
        wire_inventory_controls_button();
        wire_create_new_item_button();
    });
};

var wire_login_form = function() {
    $( '#login_user' ).submit( function( e ) {
        e.preventDefault();
        $.ajax({
            type    : 'POST',
            url     : '/account/login',
            success : function( data ) {
                console.log( 'Login succes' );
            }
        });
    });
};

var wire_create_inventory_form = function() {
	$( '#create_new_inventory' ).click( function( e ) {
		e.preventDefault();
		$.ajax({
			url		: '/inventories/new',
			type    : 'GET',
            success : function( data ) {
                var temp_html = $( '#inventory_control' ).html();
                $( '#new_inventory_section' ).html( data );
                wire_create_new_inventory_button( temp_html );
                wire_cancel_new_inventory_button( temp_html );
            }
		});
	});
};

var wire_create_new_inventory_button = function( html ) {
    $( '#create_new_inventory_button' ).click( function( e ) {
        e.preventDefault();
        console.log('e: ' + e.target.id);
        $.ajax({
            type    : 'POST',
            url     : '/inventories/create',
            data    : {
                inventory_name  : $( '#nameField' ).val()
            },
            success : function( data ) {
                wire_inventory_list();
                $( '#inventory_control' ).html( html );
                wire_create_inventory_form();
            }
        });
    });
};

var wire_create_new_item_button = function() {
    $( '#create_new_item' ).click( function( e ) {
        e.preventDefault();
        //TODO: get current inventory from session.
        $.ajax({
            type    : 'POST',
            url     : '/item/create',
            data    : {
                name                : $( '#nameField'               ).val(),
                packaging           : $( '#packagingField'          ).val(),
                content             : $( '#contentField'            ).val(),
                unit                : $( '#unitField'               ).val(),
                add_to_inventory    : $( '#add_to_inventoryField'   ).val()
            },
            success : function( data ) {
                show_notification( data );
            }
        });
    });
};

var wire_cancel_new_inventory_button = function( html ) {
    $( '#cancel_new_inventory_button' ).click( function( e ) {
        e.preventDefault();
        $( '#inventory_control' ).html( html );
        wire_create_inventory_form();
    });
};

var wire_register_form_button = function() {
	$( '#register_button' ).click( function( e ) {
		e.preventDefault();

		$.ajax({
            type    : 'GET',
            url     : '/register',
            success : function( data ) {
                $( '#login_user'	).addClass( 'disabled'		);
                $( '#emailField' 	).attr( 'disabled', 'yes' 	);
                $( '#passwordField'	).attr( 'disabled', 'yes' 	);
                $( '#login_button'	).attr( 'disabled', 'yes' 	);
                $( '#register_section' ).html( data );

                wire_register_account_button();
            }
        });
	});
};

var wire_register_account_button = function() {
	$( '#register_user' ).submit( function( e ) {
		e.preventDefault();

		$.ajax({
			type	: 'POST',
            data    : {
                'username'  : $( '#registerEmailField'      ).val(),
                'password'  : $( '#registerPasswordField'   ).val()
            },
			url     : '/account/create',
			success	: function( data ) {
				$( '#login_user'	    ).removeClass( 'disabled'	);
				$( '#emailField' 	    ).removeAttr( 'disabled'	);
				$( '#passwordField'	    ).removeAttr( 'disabled'	);
				$( '#login_button'	    ).removeAttr( 'disabled'	);
				$( '#register_section'  ).html('<h1>Your account has been created.</h1><div>Thanks for registering an account with us. You shortly will receive an email with confirmation link. Please click on the link and confirm that you wish to register for this website.</div>');
			}
		});
	});
};

var wire_inventory_list = function() {
    $.ajax({
        type    : 'GET',
        url     : '/inventories/list',
        success : function( data ) {
            var options = '';
            
            $( data ).each( function() {
                options += '<option value="' + this.guid + '">' + this.name + '</option>'
            });

            $( '#inventory_list'        ).html( options );
            $( '#choose_inventory_list' ).html( options );
        }
    });
};

var wire_search_inventory_item = function() {
    $( '#search_inventory_item' ).focus( function( e ) {
        
        if ( $( this ).val() ==='Search items in your inventory' ) {
            $( this ).val( '' );
        }
        
        $( '.item_in_list' ).removeClass( 'hide' );
    })
    .blur( function() {
        if ( $( this ).val() === '' ) {
            $( this ).val( 'Search items in your inventory' );
        }
    })
    .keyup( function( e ) {
        var value = $( this ).val();
        value = value.toLowerCase();
        $( '.item_in_list' ).each( function() {
            
            var str     = $( this ).text();
            str         = str.toLowerCase();
            var match   = str.search( value );

            if ( match == -1 ) {
                $( this ).addClass( 'hide'      );
            } else {
                $( this ).removeClass( 'hide'   );
            }
        });
    });  
};

var wire_inventory_controls_button = function() {
    $( '#inventory_controls' ).click( function( e ) {
        $( '#inventory_control' ).toggle( 'fast' );
    });
};

var populate_inventory_table = function() {
    var html = '<tr class="odd item_in_list"><td><img src="/images/bullet_delete.png" /></td><td>Pepsi Light</td><td><img src="/images/bullet_green.png" /></td></tr>';
    html += '<tr class="even item_in_list"><td><img src="/images/bullet_delete.png" /></td><td>Pepsi Max</td><td><img src="/images/bullet_green.png" /></td></tr>';
    $( '#inventory_table tbody' ).html( html );
    $( '.tablesorter' ).tablesorter({
        debug : true
        //sortList : [[1,0]]
    }); 
};

var show_notification = function( data ) {
	noty({ 
		timeout	: 3000,
		text	: data.text,
		type	: data.type
	});
};
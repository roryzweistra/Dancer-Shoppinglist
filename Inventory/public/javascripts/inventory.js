$( document ).ready( function() {
	init_pjax();
	wire_create_inventory();
	wire_register_form_button();
	wire_register_account_button();
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
		wire_create_inventory();
		wire_register_form_button();
		wire_register_account_button();
        });
};

var wire_create_inventory = function() {
	$( '#create_inventory' ).submit( function( e ) {
		e.preventDefault();
		$.pjax({
			url		: '/inventories',
			container	: '#main',
			fragment	: '#pjax'
		});
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
			url	: '/account/create',
			success	: function( data ) {
				$( '#login_user'	).removeClass( 'disabled'	);
				$( '#emailField' 	).removeAttr( 'disabled'	);
				$( '#passwordField'	).removeAttr( 'disabled'	);
				$( '#login_button'	).removeAttr( 'disabled'	);
				$( '#register_section' ).html('<h1>Your account has been created.</h1><div>Thanks for registering an account with us. You shortly will receive an email with confirmation link. Please click on the link and confirm that you wish to register for this website.</div>');
			}
		});
	});
};

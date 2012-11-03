$( document ).ready( function() {
	init_pjax();
	wire_create_inventory();
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

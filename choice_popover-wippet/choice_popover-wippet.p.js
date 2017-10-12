$(document).ready(function(event){
	
    //choice_popover-wippet.p.js implements Bootstrap Popover
	//for the XSLT code and further documentation see choice_popover-wippet.p.xsl
    $('[data-toggle="popover"]').on('click',function(e){
					// Cancel the default action of hyperlinks
					e.preventDefault();
			}).popover({ html : true});
	
	
});
(function ( $ ) {
	
	/*simpleCheckboxMenu (SCM): JQUery Plugin for simple Dom visualisation via toggling a class
	The Plugin attaches a click event (may be changed to any other event).
	On the checkbox input element the class 'scm-checkbox' is required
	Also required are two additional attributes on the checkbox:
	"data-scm-target": contains a Jqery selector string to the elements on which the class should be toggled
	"data-scm-class": contains the class name that should be toggled on the above elements
	
	In the simpleCheckbxMenu.div.css file are some predefined classed that can be used, new ones can be added there.
	
	*/
	
	$(document).ready(function(){
		
		
		
		function triggerEvent($ele){
		    
		    var target = $($ele).attr("data-scm-target");
			var classToToggle = $($ele).attr("data-scm-class");
			
			//console.log("Target Jquery selector is: "+target);
			//console.log("Class to toggle is: "+classToToggle);
			
			$(target).toggleClass(classToToggle);
		    
		}
		
		
		$("input.scm-checkbox").on("click", function(){
			//console.log("click event works");
			triggerEvent(this);
			
		});	
		 
		    $("input.scm-checkbox:checked").each(function(){
		    //console.log("checkbox checked event works");
		      triggerEvent(this);
		    
		    });
		
		
		 });
		
		
			
	}(jQuery));




















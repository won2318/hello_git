	
    function this_close(){ 
    	if (  document.getElementById("silver_player") != null) {
    		StopSilverlight();
    	} 
   	 parent.$.colorbox.close();
    }
    
 
    function go_home(){
     
    	if (  document.getElementById("silver_player") != null) {
    		StopSilverlight();
    	} 
    	 parent.location.href="/";
     	 parent.$.colorbox.close();
 
    }
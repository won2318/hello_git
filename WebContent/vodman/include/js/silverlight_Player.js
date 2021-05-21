
	function silverLight(layer, ocode) {
		var  player = "<div id='errorLocation' style=\"font-size: small;color: Gray;\"></div> \n"
				+ "<div id=\"silverlightControlHost\"> \n"
		 		+ "<object data=\"data:application/x-silverlight-2,\" type=\"application/x-silverlight-2\" width=\"428\" height=\"375\"> \n"
		 		+ "<param name=\"source\" value=\"/ClientBin/player.xap\"/> \n"
		 		+ "<param name=\"onerror\" value=\"onSilverlightError\" /> \n"
		 		+ "<param name=\"background\" value=\"white\" /> \n"
		 		+ "<param name=\"minRuntimeVersion\" value=\"2.0.31005.0\" /> \n"
		 		+ "<param name=\"autoUpgrade\" value=\"true\" /> \n"
		 		+ "<a href=\"http://go.microsoft.com/fwlink/?LinkID=124807\" style=\"text-decoration: none;\"> \n"
		 		+ "<img src=\"http://go.microsoft.com/fwlink/?LinkId=108181\" alt=\"Get Microsoft Silverlight\" style=\"border-style: none\"/> \n"
		 		+ "</a> \n"
		 		+ "<param name=\"initParams\" value=\"ocode="+ocode+"\" /> \n"
		 		+ "</object> \n"
		 		+ "<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe> \n"
		 		+ "</div>";
		document.getElementById(layer).innerHTML = player;
	}
	 
	
	
	
	
	
	
	
			
	
	




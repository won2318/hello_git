var cc=0;
function showHide(id) {
		
			if (cc==0) {
					cc=1
					document.getElementById(id).style.display="block";
			} else {
					cc=0
					document.getElementById(id).style.display="none";
			}
	}

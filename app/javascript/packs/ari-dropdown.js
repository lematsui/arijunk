if (document.querySelector(".rotate")) {
	$(".rotate").click(function(){
	    $(this).toggleClass("down");
	    const menu = document.querySelector(".aridrop-box");
	    if (menu.style.maxHeight){
      	menu.style.maxHeight = null;
    	} else {
      	menu.style.maxHeight = menu.scrollHeight + "px";
    	}; 
	});
};
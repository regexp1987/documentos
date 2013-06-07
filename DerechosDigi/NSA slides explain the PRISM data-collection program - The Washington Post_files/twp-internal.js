(function() {	
	var isSSL = (window.location.protocol.indexOf('https')) < 0?false:true;
	var wpostServerSsl = 'https://ssl.washingtonpost.com/wpost';
	TWP = window.TWP || {};
	TWP.base = TWP.base || 'http://www.washingtonpost.com';
	TWP.wpostCssBase = TWP.wpostCssBase || 'http://css.washingtonpost.com';
	TWP.wpostJsBase = TWP.wpostJsBase || 'http://js.washingtonpost.com';
	TWP.wpostJsBaseSsl = TWP.wpostJsBaseSsl || 'https://ssl.washingtonpost.com';	
	TWP.jsCacheBuster = TWP.jsCacheBuster || '20130529154900';
	TWP.cssCacheBuster = TWP.cssCacheBuster || '20130528161400';
	TWP.ScriptLoader = TWP.ScriptLoader || {};
	TWP.ScriptLoader.scriptArray = TWP.ScriptLoader.scriptArray || [];
	var inlineJsScriptArray = [];
		
	TWP.ScriptLoader.loadjscssfile = function(filename, filetype){
		var inlineArray = [];
		if (filename.length == 0) return;
		if (isSSL) {
			filename = ((filetype == "js" || filetype == "cjs")?filename.replace(TWP.wpostJsBase,TWP.wpostJsBaseSsl):filename);
			filename = ((filetype == "css")?filename.replace(TWP.wpostCssBase,TWP.wpostJsBaseSsl):filename);
		}
		 if (filetype=="js"){ //if filename is a JavaScript file
			  var fileref=document.createElement('script');
  		  	  fileref.setAttribute("type","text/javascript");
			  fileref.setAttribute("src", filename);
			  inlineJsScriptArray.push(fileref);
		 }	else if (filetype=="cjs"){ //if filename is a JavaScript file
			  var fileref=document.createElement('script');
  		  	  fileref.setAttribute("type","text/cjs");
			  fileref.setAttribute("data-cjssrc", filename);
			  TWP.ScriptLoader.scriptArray.push(fileref);
		 }	else if (filetype == "inline"){ //if filename is inline javascript file
			  var fileref=document.createElement('script');
			  fileref.setAttribute("type","text/cjs");
			  fileref.text = filename;
	  		  TWP.ScriptLoader.scriptArray.push(fileref);
		 } else if (filetype=="css"){ //if filename is an external CSS file
			  var fileref=document.createElement("link");
			  fileref.setAttribute("rel", "stylesheet");
			  fileref.setAttribute("type", "text/css");
			  fileref.setAttribute("href", filename);
			  if (typeof fileref != "undefined")
		  			document.getElementsByTagName("head")[0].appendChild(fileref);
		 }

	}
	 
	
	TWP.ScriptLoader.processScriptArray = function() { 
		if ( TWP.ScriptLoader.scriptArray.length ) {
			var script = TWP.ScriptLoader.scriptArray[0];			
			var src = CJS.getAttribute(script, "data-cjssrc"); 
			if ( src ) {
				// External Script 
				if(!CJS.hExec[src]) {				
					CJS.processExternalScript(script, TWP.ScriptLoader.processScriptArray); 
					CJS.hExec[src] = true;
					TWP.ScriptLoader.scriptArray.splice(0, 1);   // remove leading script
				}
				else {
					TWP.ScriptLoader.scriptArray.splice(0, 1);   // remove leading script
					setTimeout(TWP.ScriptLoader.processScriptArray,0);
				}
			} else {
				// Inline Script
				if (0 === CJS.aExecs.length) { //make sure previous scripts loaded before executing inline script
					CJS.processInlineScript(script);
					TWP.ScriptLoader.scriptArray.splice(0, 1); // remove leading script
				}	
				setTimeout(TWP.ScriptLoader.processScriptArray, 0);
			}
			
			return; 
		}
	}

	
	TWP.ScriptLoader.loadCJS = function () {
		if (typeof CJS == 'undefined') {
			  <!--  -->

		
			jsControlJs = '|<script type="text/cjs" data-cjssrc="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/controljs/control-mod.js"></script>';		
			var cjsscript = document.createElement('script');
			cjsscript.onload = cjsscript.onreadystatechange = 
				function(){
					if ( this.readyState && this.readyState != "complete" && this.readyState != "loaded" ) {
						return; 
					}			
					TWP.ScriptLoader.processScriptArray();
				}
			cjsscript.src = jsControlJs.substring(jsControlJs.indexOf('src="')+5,jsControlJs.indexOf('"></script>'));
			if (isSSL) {
				cjsscript.src = cjsscript.src.replace(TWP.wpostJsBase,TWP.wpostJsBaseSsl);
			}
			var cjssib = document.getElementsByTagName('script')[0];
			cjssib.parentNode.insertBefore(cjsscript, cjssib);
		} else {
			TWP.ScriptLoader.processScriptArray();
		}	
	}	
	 
	
	if (typeof jQuery == 'undefined'){
		<!--  -->


		var jsJQuery = '|<script type="text/javascript" src="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/jquery-1.7.1.js"></script>';				
		TWP.ScriptLoader.loadjscssfile(jsJQuery.substring(jsJQuery.indexOf('src="')+5,jsJQuery.indexOf('"></script>')), "js");
	}		
		
			
	var jsList = '';
	<!--  -->


				jsList = jsList + '|<script type="text/javascript" src="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/conf.js&r=/actmgmt/acctmgmt_common.js&r=/plugin/plugin.jquery.parseparams.js&r=/plugin/plugin.jquery.cookie-1.0.0.js"></script>';			
	<!--  -->


				jsList = jsList + '|<script type="text/cjs" data-cjssrc="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/core-1.0.0.js&r=/constants-1.0.0.js&r=/static-methods-1.0.0.js&r=/util/util.cookie-1.0.0.js"></script>';			
	<!--  -->


				jsList = jsList + '|<script type="text/cjs" data-cjssrc="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/util/util-user-2.0.0.js&r=/util/util.identity-management-1.0.0.js"></script>';			
	<!--  -->


				jsList = jsList + '|<script type="text/cjs" data-cjssrc="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/plugin/plugin.jquery.parseparams.js&r=/util/util.overlay-2.0.0.js&r=/util/util.overlay-helper-2.0.0.js"></script>';			
	<!--  -->


				jsList = jsList + '|<script type="text/cjs" data-cjssrc="http://js.washingtonpost.com/wpost/js/combo?token=20130529154900&c=true&m=true&context=eidos&r=/plugin/plugin.jquery.imageLazyLoader-1.0.0.js&r=/module/module.menus-2.0.0.js&r=/module/module.external-header-v4-2.0.0.js&r=/module/module.external-footer-v4-2.0.0.js&r=/util/util.track-click-1.0.0.js&r=/init/init.track-header-1.0.0.js&r=/util/util.header-detection-1.1.0.js"></script>';			
	(function() {
					TWP.jsConfig = TWP.jsConfig || {};
					TWP.jsConfig.initFunctions = TWP.jsConfig.initFunctions || [];
					
					var thisInit = function(base) {
					    var el = base.find('.ajax-overlay, .iframe-overlay, .clone-overlay');
			        if (el.length > 0) {
			            el.each(function (i, node) {
			                new TWP.OverlayHelper(node);
			            });
			        }
					};
					
					TWP.jsConfig.initFunctions.push(thisInit);
				
					//inits done from twp-scripts.
				})();;

	jsList = jsList + '|if (TWP.jsConfig && TWP.jsConfig.initFunctions){for(var a=0; a<TWP.jsConfig.initFunctions.length; a++) {TWP.jsConfig.initFunctions[a]($("body"));}}';
	<!--  -->


	var cssList = '|<link rel="stylesheet" type="text/css" href="http://css.washingtonpost.com/wpost/css/combo?token=20130528161400&inttoken=20130515174700&c=true&m=true&context=eidos&r=/2.0.0/external-header-base.css&r=/2.0.0/fonts.css&r=/2.0.0/header.css&r=/2.0.0/footer.css&r=/2.0.0/ads.css" />';	
		
	
	var tmpArray = cssList.split('|');
	for (i=0;i<tmpArray.length;i++){
		var tmpFile = tmpArray[i].substring(tmpArray[i].indexOf('href="')+6,tmpArray[i].lastIndexOf('/>')).replace(/[" >]/g,'');
		if (tmpFile != ''){TWP.ScriptLoader.loadjscssfile(tmpFile, "css");};
	}	

	
	tmpArray = jsList.split('|');
	for (i=0;i<tmpArray.length;i++){
		var scriptSrc = tmpArray[i].substring(tmpArray[i].indexOf('src="')+5,tmpArray[i].indexOf('"></script>'));
		if (tmpArray[i].indexOf('data-cjssrc="') > -1){		
			TWP.ScriptLoader.loadjscssfile(scriptSrc, "cjs");
		} else if (tmpArray[i].indexOf('src="') > -1){		
			TWP.ScriptLoader.loadjscssfile(scriptSrc, "js");			
		} else {
			TWP.ScriptLoader.loadjscssfile(tmpArray[i], "inline");
		}	
	}

	
	for (i=0;i<inlineJsScriptArray.length;i++){
				
		document.write('<script type="text/javascript" src="' + inlineJsScriptArray[i].attributes["src"].value +'"></script>');
	}

	if (!TWP.ScriptLoader.listener) {
		if (document.addEventListener ) {
			document.addEventListener("DOMContentLoaded", 				
				function(){
	        		//if ( document.readyState === "complete" || document.readyState === "interactive" ) {
	                        document.removeEventListener( "load", arguments.callee, false );
	                        TWP.ScriptLoader.loadCJS();
	                        if (typeof triggerJS != "undefined" && typeof triggerJS == "function") {triggerJS()};
	                //}	
				}
			,false);
			TWP.ScriptLoader.listener = true;
		} else if ( document.attachEvent ) {			
	        document.attachEvent("onreadystatechange", function(){
	        		if ( document.readyState === "complete" || document.readyState === "interactive" ) {
	                        document.detachEvent( "onreadystatechange", arguments.callee );
	                        TWP.ScriptLoader.loadCJS();
	                        if (typeof triggerJS != "undefined" && typeof triggerJS == "function") {triggerJS()};
	                }	  	                    
	        });
	        TWP.ScriptLoader.listener = true; 

		} 	
	}

})();



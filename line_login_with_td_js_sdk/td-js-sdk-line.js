// send to TD
<script type = "text/javascript">
    !function(t,e){if(void 0===e[t]){e[t]=function(){e[t].clients.push(this),this._init=[Array.prototype.slice.call(arguments)]},e[t].clients=[];for(var r=function(t){return function(){return this["_"+t]=this["_"+t]||[],this["_"+t].push(Array.prototype.slice.call(arguments)),this}},s=["blockEvents","unblockEvents","setSignedMode","setAnonymousMode","fetchUserSegments","resetUUID","fetchServerCookie","addRecord","fetchGlobalID","set","trackEvent","trackPageview","trackClicks","ready"],n=0;n<s.length;n++){var c=s[n];e[t].prototype[c]=r(c)}var o=document.createElement("script");o.type="text/javascript",o.async=!0,o.src=("https:"===document.location.protocol?"https:":"http:")+"//cdn.treasuredata.com/sdk/2.2.0/td.min.js";var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(o,a)}}("Treasure",this);
</script> 

<script type = "text/javascript">
	(function() {
		liff.ready
			.then(function() {
				if (liff.isLoggedIn()) {
					liff
						.getProfile()
						.then(function(profile) {
							return {
								line_user_id: profile.userId,
								line_disp_name: profile.displayName
							};
						})
						.then(function(lineUserData) {
							sendTd('YOUR_TREASUREDATA_TABLE_NAME', 'login', lineUserData) //送信先テーブル名指定
						})
				}
			})
	}());

function sendTd(table, event, lineUserData) {
	var hostName = location.hostname;
	var sscDomains = {
		'YOUR_DOMAIN': 'ssc' //sscの設定をしているドメイン
	};
	var initParams = {
		host: 'in.treasuredata.com', //TDのリージョンで変更
		writeKey: 'YOUR_TREASUREDATA_APIKEY', //TD API KEY入力
		database: 'YOUR_TREASUREDATA_DATABASE_NAME', //送信先データベース名指定
		startInSignedMode: true
	};
	if (location.protocol == 'https:') {
		Object.keys(sscDomains).forEach(function(key) {
			var p = new RegExp('^(.*\\.)?' + key.replace(/\./g, '\\.') + '$');
			if (p.test(hostName)) {
				initParams["useServerSideCookie"] = true;
				initParams["sscDomain"] = key;
				initParams["sscServer"] = sscDomains[key] + '.' + key;
			}
		});
	}
	var td = new Treasure(initParams);

	if (event != undefined) {
		td.set(table, 'event', event);
	}

	if (lineUserData != undefined) {
		td.set(table, lineUserData);
	}
	td.set('$global', 'td_global_id', 'td_global_id');

	try {
		td.fetchServerCookie(successCallback, errorCallback);
	} catch (e) {
		fireEvents();
	}

	function fireEvents() {
		var url = location.href;
		var base_url = url.replace(/\?.*$/, "");
		td.set(table, 'td_url', base_url);
		td.trackEvent(table);
	}

	function successCallback(result) {
		td.set('$global', {
			td_ssc_id: result
		});
		fireEvents();
	}

	function errorCallback() {
		fireEvents();
	}
} 
</script>

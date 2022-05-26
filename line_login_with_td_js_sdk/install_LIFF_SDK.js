// liff init
<!-- load liff SDK -->
<script charset = "utf-8" src = "https://static.line-scdn.net/liff/edge/2/sdk.js"> </script> 
<script type = "text/javascript">
	liff.init({
		liffId: "YOUR_LIFF_ID" //LIFF IDを入力
	})
	.then(function() {
		dataLayer.push({
			'event': 'liffInit',
			'liffInit': 1
		});
	})
	.catch(function(err) {
		// Error happens during initialization
		console.log(err.code, err.message);
	}); 
</script>

<script type = "text/javascript">
	function lineLogin() {
		liff.ready.then(function() {
			if (!liff.isLoggedIn()) {
				liff.login({
					redirectUri: "https://hogehoge.com/" //ログイン後のリダイレクト先URLを入力
				});
			}
		});
	}

function lineLogOut() {
	liff.ready.then(function() {
		if (liff.isLoggedIn()) {
			liff.logout();
		}
	});
} 
</script>
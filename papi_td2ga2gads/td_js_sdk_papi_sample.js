<!-- Treasure Dataa -->
<script type="text/javascript">
!function(t,e){if(void 0===e[t]){e[t]=function(){e[t].clients.push(this),this._init=[Array.prototype.slice.call(arguments)]},e[t].clients=[];for(var r=function(t){return function(){return this["_"+t]=this["_"+t]||[],this["_"+t].push(Array.prototype.slice.call(arguments)),this}},s=["blockEvents","unblockEvents","setSignedMode","setAnonymousMode","resetUUID","addRecord","fetchGlobalID","set","trackEvent","trackPageview","trackClicks","fetchUserSegments","ready"],n=0;n<s.length;n++){var c=s[n];e[t].prototype[c]=r(c)}var o=document.createElement("script");o.type="text/javascript",o.async=!0,o.src=("https:"===document.location.protocol?"https:":"http:")+"//cdn.treasuredata.com/sdk/2.1/td.min.js";var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(o,a)}}("Treasure",this);

  // Configure an instance for your database
  var td = new Treasure({
    host: 'in.treasuredata.com',
    writeKey: 'YOUR_API_KEY',
    database: 'YOUR_DB_NAME',
    startInSignedMode: true
  });
  
  var cdp_token = 'YOUR_CDP_TOKEN';

  //'AddTdSegments'というイベント名でdataLayerにセグメントIDの書き出し
  var dataLayer = dataLayer || [];
  var successCallback = function(segments){
    console.log(segments);
    var segIdAll = [];
    var len = segments.length;
    for (var i = 0; i < len; i++){
      segIdAll = segIdAll.concat(segments[i].values);
    };
    var segId = segIdAll.filter(function(x,i,self){return self.indexOf(x) === i;});
    console.log({
      event:'AddTdSegments', // Event name you set on GTM
      td_client_id: td_client_id,
      td_segment_id: segId.join(',')
    });
    dataLayer.push({
      event:'AddTdSegments', // Event name you set on GTM
      td_client_id: td_client_id,
      td_segment_id: segId.join(',')
    });
  };
 
  //'td_client_id'をKEYにする場合JS内で呼び出す必要がある
  var getcookie=function(a){var b=document.cookie;if(b)for(var c=b.split("; "),d=0;d<c.length;d++){var b=c[d].split("=");if(b[0]===a)return b[1]}return"null"};
  td_client_id = getcookie('_td')
  
  //'fetchUserSegments'関数でセグメントの呼び出し
  td.fetchUserSegments({
    audienceToken: [cdp_token],
    keys: {td_client_id: td_client_id}
  }, successCallback);

  td.set('$global', 'td_global_id', 'td_global_id');
  td.trackPageview('YOUR_TABLE_NAME');
</script>

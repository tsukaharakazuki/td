widget.show();
var EVENT_NAME = 'treasure_data_values';
if (!window['Treasure']) return;
var host = '#{host}';
var writeKey = '#{writeKey}';
var database = '#{database}';
var cdpHost = '#{cdpHost}';
var token = '#{token}';
var td = new Treasure({
    host: host,
    writeKey: writeKey,
    database: database,
    cdpHost: cdpHost
});

var tdVersion = td.version;
var ck = getTdCookie('_td_ssc_id') === null ? getTdCookie('_td') : getTdCookie('_td_ssc_id');
td.fetchUserSegments({
    audienceToken: [token],
    keys: {
        cookie: ck
    }
}, success, error);
function success(a, b) {
    if (!a && !b) return;
    if (tdVersion > "1.0" && tdVersion < "2.1" ) {
        var keys = a;
        var segments = b;
        trackTDv1Values(keys, segments);
  } else if (tdVersion >= "2.1"){
        var audiences = a;
        trackTDv2Values(audiences);
  }
}
function trackTDv1Values(keys, segments) {
    tracker.track(EVENT_NAME, {
        segments: segments
    });
}
function trackTDv2Values(audiences) {
    var segments = [];
    audiences.forEach(function(audience) {
        if (audience.values) segments = segments.concat(audience.values);
    });
    tracker.track(EVENT_NAME, {
        segments: segments
    });
}
function error(err) {
    tracker.track('_error', {
        error_message: err.message || err
    });
}
function getTdCookie(key) {
    var cookieKey = key + "=";
    var val = null;
    var cookie = document.cookie + ";";
    var index = cookie.indexOf(cookieKey);
    if (index != -1) {
        var endIndex = cookie.indexOf(";", index);
        val = decodeURIComponent(cookie.substring(index + cookieKey.length, endIndex));
    }
    return val;
}
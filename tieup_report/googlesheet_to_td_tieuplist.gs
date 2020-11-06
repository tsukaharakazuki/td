var tdEndpoint = 'https://in.treasuredata.com/js/v3/event/';
var tdApikey   = 'YOUR_API_KEY';  // write onlyのAPIキー
var targetDb_tieuplisttemp = 'tie_up_report' //レポート集計WFで定義しているDB名
var targetTable_tieuplisttemp = 'tieup_list_tmp' //タイアップ集計リストtmpテーブル名
 
// TreasureDataへPOSTする
function postRecords_tieuplisttemp(database, table, records) {
  var options = {
    "method": "POST",
    "contentType" : "application/json",
    "headers" : {
      "X-TD-Write-Key": tdApikey,
      "X-TD-Data-Type": "k" 
    }
  };
  var payload = {};
  payload[database + "." + table] = records;
  options["payload"] = JSON.stringify(payload);
  var response = UrlFetchApp.fetch(tdEndpoint, options);
}

// TreasureDataへImportするデータをスプレッドシートから取得する
// ここは実際のデータの内容にあわせて適宜変更してください
function getData_tieuplisttemp() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var as = ss.getSheetByName('tieup_list'); //該当のシート名を記入
  var lastRow = as.getLastRow();
  // 2行目A列~最終行M列のデータを取得
  var select = as.getRange(2,1,lastRow - 1,16).getValues();
  var records = [];
  for (var i = 0; i < (lastRow-1);i++){
    // 実際にImportするレコードデータを作る
    records.push({
      "article_id": select[i][0],
      "start_date": select[i][1],
      "end_date": select[i][2],
      "check_host_flag": select[i][3],
      "check_host": select[i][4],
      "db_client_name": select[i][5],
      "db_label": select[i][6],
      "c_1": select[i][7],
      "c_2": select[i][8],
      "c_3": select[i][9],
      "c_4": select[i][10],
      "c_5": select[i][11],
      "ls_page_url": select[i][12],
      "ls_client_name_jp": select[i][13],
      "ls_page_title": select[i][14],
      "media_name": select[i][15],
      "time": Math.floor((new Date()).getTime()/1000)  // 1リクエストで複数行入れる場合はtimeカラムが必須
    });
  }
  return records;
}
 
// メインの処理
function import_tieuplisttemp() {
  var records = getData_tieuplisttemp();
  // 1000行ずつPOSTする
  for(var i = 0; i < Math.ceil(records.length / 1000); i++) {
    var j = i * 1000;
    var c = records.slice(j, j + 1000);
    postRecords_tieuplisttemp(targetDb_tieuplisttemp, targetTable_tieuplisttemp, c);
  }
}
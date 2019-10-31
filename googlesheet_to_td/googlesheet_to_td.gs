CONSTANTS = {
  maxColumns: 1000,
  rowsPerRead: 200,
  maxRows: 100,
  tdAPIKey: 'YOUT_API_KEY', //write only keyを記入
  databaseName: 'DB?NAME', //DB名を記入
  tableName: 'TABLE_NAME', //テーブル名を記入
  timeColName: "time",
  timeLowerBound: Date.parse(new Date())/1000 - 7*86400,
  timeUpperBound: Date.parse(new Date())/1000 + 3*86400
}

function toTDEntityName(name) {
  return name.toLowerCase().replace(/[^a-z0-9_]/g, '_').replace(/_+/, '_');
}

function postTreasureData(events, database, table, apikey) {
  var data = {};
  data[database+"."+table] = events;
  var payload = JSON.stringify(data);
  Logger.log(payload);
  var options = {
    "method": "POST",
    "contentType" : "application/json",
    "headers" : {
      "X-TD-Write-Key": apikey,
      "X-TD-Data-Type": "k"
    },
    "payload": payload
  };
  var response = UrlFetchApp.fetch("http://in.treasuredata.com/js/v3/event/", options);
  Logger.log(response);
}

function readColumnNames(activeSheet) {
  // Parse column names
  // Assume that the table begins on A1, with the first row as the header
  var colNames = [];
  var colIndex = 1;
  while (colIndex < CONSTANTS.maxColumns) {
    var colName = activeSheet.getRange(1, colIndex).getValue();
    if (colName === "") { break; }
    colNames.push(colName);
    colIndex += 1;
  }
  return colNames;
}

function validateTimeColumn(o) {
  var t = o[CONSTANTS.timeColName];
  if (typeof t === "number") {
    // check that the time is within reason
    if (t < CONSTANTS.timeLowerBound || t > CONSTANTS.timeUpperBound) {
      throw new RangeError("time field = " + t.toString() + " is out of range");
    }
    return o; // otherwise good.
  }
  if (typeof t === "string" || t instanceof Date) {
    var parsed_t = Date.parse(t)/1000;
    if (parsed_t !== parsed_t) { // If it's NaN
      throw new Error("time field = " + t.toString() + " is malformed");
    }
    // check that the time is within reason
    if (parsed_t < CONSTANTS.timeLowerBound || parsed_t > CONSTANTS.timeUpperBound) {
      throw new RangeError("time field = " + parsed_t.toString() + " is out of range");
    }
    o[CONSTANTS.timeColName] = parsed_t;
    return o;
  }
  throw new Error("Bad type");
}

function readMultipleRows(activeSheet, rowIndex, colNames, rowCount) {
  var rowJSONs = [];
  for (var offset = 0; offset < rowCount; offset++) {
    // If all values are empty in the row, then we assume that it's the end
    // activeSheet.getRange(rowIndex+offset, 1).getValue() === "") { break; }
    var rowValues = activeSheet.getRange(rowIndex+offset, 1, 1, colNames.length).getValues();
    var isEnd = true;
    for (var ii in rowValues) {
      if (rowValues[0][ii] !== "") {
        isEnd = false;
        break;
      }
    }
    if (isEnd) { break; }
    rowJSONs.push((function() {
      var o = {};
      for (var ii in colNames) {
        o[colNames[ii]] = rowValues[0][ii];
      }
      validateTimeColumn(o);
      return o;
    })());
  }
  return rowJSONs;
}

function GoogleSheet2TD() {
  var activeSpreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var databaseName = CONSTANTS.databaseName || toTDEntityName(activeSpreadsheet.getName());
  var activeSheet = activeSpreadsheet.getSheetByName('SHEET_NAME'); //シート名を指定
  var tableName = CONSTANTS.tableName || toTDEntityName(activeSheet.getName());
  var tdAPIKey = CONSTANTS.tdAPIKey;
  colNames = readColumnNames(activeSheet);

  var rowJSONs;
  var rowIndex = 2;
  while (rowIndex < CONSTANTS.maxRows) {
    rowJSONs = readMultipleRows(activeSheet, rowIndex, colNames, CONSTANTS.rowsPerRead);
    if (rowJSONs.length === 0) { break; }
    postTreasureData(rowJSONs, databaseName, tableName, tdAPIKey);
    rowIndex += rowJSONs.length;
  }
}

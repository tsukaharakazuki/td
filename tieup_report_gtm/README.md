# はじめに

このWorkflowは、メディア企業向けにタイアップ広告のレポートを半自動的に生成するWorkflowサンプルです。  


# 準備

## GTMでスクロール距離、Click計測の設定

通常のpageviewトラッキングとは別で、スクロール距離、クリックの計測を実施する必要があります。
データ取得の設定については、担当までお問い合わせください。


## TDへのdig/queryファイルアップロード

digファイル、queryファイルをダウンロードいただき、CLIからTD環境にアップロードをお願いします。
First, please upload your workflow project by `td wf push` command.
```
# Upload
$ td wf push tieup_report_gtm
```


## 結果出力DBの作成

このサンプルでは`tie_up_report`というDBにデータを出力しています。


## 地図表示用対照表のアップロード

`jp_dev_mst.csv`をTDコンソールからデータベース`tie_up_report`にアップロードしてください。
TDのUDFでIPアドレスを分解すると、都道府県パースが可能ですが、ダッシュボードの地図で表示させるために表記揺れが存在します。こちらのデータで変換作業を取り込んでいます。
※すでにダッシュボード用などでアップロードしている場合、そちらを設定いただいても構いません。


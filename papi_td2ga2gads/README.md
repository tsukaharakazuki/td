# はじめに
  
TDの提供するProfileAPIを活用し、GAを経由してGoogleAdsにTDで作ったセグメントを連携する方法です。td_js_sdkのバージョンによって若干JSの記述が異なります。今回のサンプルではv2.1.0で作成をしています。
  
## GA設定
  
1-1.カスタムディメンションの設定
![GA1-1](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_1.png?raw=true "GA1-1")  
  
1-2.新しいカスタムディメンション
![GA1-2](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_2.png?raw=true "GA1-2")  
  
1-3.カスタムディメンション`td_segment_id`の作成
![GA1-3](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_3.png?raw=true "GA1-3") 
  
1-4.カスタムディメンションのインデックスを確認
![GA1-4](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_4.png?raw=true "GA1-4")  
合わせてProfileAPIでKeyに設定する値（ex.`td_client_id`,`td_global_id`など）も設定してください。
  
## GTM設定
  
2-1.GTM：トリガー設定
![GTM2-1](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_5.png?raw=true "GTM2-1") 
  
2-2.GTM：トリガー`AddTdSegments`の作成
![GTM2-2](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_6.png?raw=true "GTM2-2") 
  
2-3.GTM：変数設定
![GTM2-3](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_7.png?raw=true "GTM2-3") 
  
2-4.GTM：変数`td_segment_id`の作成
![GTM2-4](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_8.png?raw=true "GTM2-4") 
  
2-5.GTM：GAユニバーサルタグの設定①
![GTM2-5](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_9.png?raw=true "GTM2-5") 
  
2-6.GTM：GAユニバーサルタグの設定②
![GTM2-6](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_10.png?raw=true "GTM2-6") 
  
## ProfileAPIタグ
  
タグは別途JSファイルをご参照ください。
  
## GAとGoogleAdsのリンク設定
  
3-1.リンク設定①
![3-1](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_11.png?raw=true "3-1") 
  
3-2.リンク設定②
![3-2](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_12.png?raw=true "3-2") 
  
3-3.GoogleAdsに送信するオーディエンス設定①
![3-3](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_13.png?raw=true "3-3") 
  
3-4.GoogleAdsに送信するオーディエンス設定②
![3-4](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_14.png?raw=true "3-4") 
  
3-5.GoogleAdsに送信するオーディエンス設定③
![3-5](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_15.png?raw=true "3-5") 
  
3-6.GoogleAdsに送信するオーディエンス設定④
![3-6](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_16.png?raw=true "3-6") 
  
3-7.GoogleAdsに送信するオーディエンス設定⑤
![3-7](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_17.png?raw=true "3-7") 
  
3-8.GoogleAdsに送信するオーディエンス設定⑥
![3-8](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_18.png?raw=true "3-8") 
  
## GoogleAdsでリストの反映確認

![4-1](https://github.com/tsukaharakazuki/image/blob/master/td_ga_papi_19.png?raw=true "4-1") 

# はじめに
  
このWorkflowは、アクセスログの閲覧傾向から記事Aと記事Bに置ける閲覧の重なりを元に、記事同士の類似を係数化するものです。
  
# Jaccard係数
  
基礎となる集計はJaccard係数です。
  
![Jaccard](https://github.com/tsukaharakazuki/image/blob/master/jaccard_1.png?raw=true? "Jaccard")
<img src="https://github.com/tsukaharakazuki/image/blob/master/jaccard_1.png"
 alt="Jaccard" title="Jaccard" width="800" height="800" />
  
二つの記事の相関を測るにあたり、
  
`両方の記事を見たユニークユーザー / 両方の記事の閲覧総ユニークユーザー`
  
という計算式で係数を算出します。係数の最大は`1`で、`1`に近いほど類似している（同じユーザーが見ている）という判断が可能です。
　　
# digファイルの変数設定
  
以下の変数を変更することで、それぞれの環境に合わせて算出が可能です。

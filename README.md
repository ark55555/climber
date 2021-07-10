# Climber
<img width="1428" alt="TOP画面" src="https://user-images.githubusercontent.com/81353374/123507686-b3d59900-d6a5-11eb-836e-602b618a9cf8.png">

## サイト概要
登山用品の投稿、閲覧ができます。
<br>下記機能導入により、商品を探しやすいようにしていますので、
<br>気になっている商品や類似商品を比較し、購入に役立てることができると考えています。
- 「タグ」検索機能
- 「ワード」検索機能（投稿）
- お気に入り登録機能

### サイトテーマ
自分が使用している登山用品の投稿をして紹介し合うSNSのサイトです。

### テーマを選んだ理由
登山用品は、高値な商品も多いため、実際に利用している人の意見を聞くことができれば、
<br>商品購入の参考につながると思い、作成しました。

### ターゲットユーザ
登山未経験の方から、登山愛好家の方まで
<br>登山商品購入を検討してる方、紹介したい商品がある方をターゲットとしています。


### 主な利用シーン
- 商品購入に迷っている際や、新しい商品の購入を検討してるときに利用者の意見を参考にすることができます。
- 自分の投稿した商品が一覧として見れたり、お気に入り登録した商品を閲覧できます。

## 設計書
- ER図
<img width="70%" alt="ER図" src="https://user-images.githubusercontent.com/81353374/123507428-3e1cfd80-d6a4-11eb-8857-be41d265df35.png">

## 機能一覧
- ユーザー機能（Gem:devise)
- 投稿機能
  - 画像投稿（Gem:refile)
  - タグ付け機能
  - 評価機能（raty.js）
- いいね機能（Ajax）
- コメント機能（Ajax）
- お気に入り登録機能（Ajax）
- フォロー機能（Ajax）
- ページング機能（Gem: kaminari）
- 検索機能（タグ検索・ワード検索）

### チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1sPBm6p_3XGsEttP31yN92hQjXXCduvIC0XAGcxdSUg8/edit#gid=0

## 開発環境
- 言語：HTML,CSS,JavaScript,Ruby,MySQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- 写真AC(https://www.photo-ac.com/)
- FLAT ICON DESIGN(http://flat-icon-design.com/)
- Pixabay(https://pixabay.com/ja/)
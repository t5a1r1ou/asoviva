# asoviva! 気軽に遊びに誘えるサービス
![asoviva!](https://i.imgur.com/QF6kvRM.png)
asoviva!は自分が遊びたい場所、遊びたい日を登録して、遊び相手を探せるサービスです。
他のSNSと違って遊び相手を探すことに特化しているため、気兼ねなく登録ができます。

# 主な機能一覧
* ユーザー管理機能
  - ユーザーのCRUD機能
  - ログイン・ログアウト機能（devise使用)
  - SNSログイン機能（Twitter、Google）
  - アイコンのアップロード機能
* フォロー機能
  - フォローアンフォロー機能（Ajax）
  - フォロワー、フォロー中ユーザー、相互フォロー表示機能（Ajax）
* 投稿管理機能
  - 投稿のCRUD機能
  - 投稿検索機能
  - お気に入り機能（Ajax）
  - mini_magickを使用した画像の生成機能
  - OGP画像作成機能
* 投稿へのコメント、リクエスト機能
  - コメント作成機能
  - 個別チャット機能（実装中）
* イベント検索機能
  - スクレイピングによる情報の取得機能
  - 検索結果からの投稿の作成機能（Ajax）

# 主な使用技術
* 開発言語・FW
  - Ruby 2.6.3
  - Rails 5.2.3
* 開発環境
  - Docker for Mac
* テスト環境
  - RSpec(単体テスト、統合テスト）
* 本番環境
  - Heroku
* DB
  - PostgresQL
* CI/CD
  - CircleCI
* フロントエンド
  - Materialize
* ユーザー管理機能
  - devise
* 画像アップロード機能
  - Active Storage
  - S3
  - CloudFront
* ページネーション機能
  - kaminari
* 個別チャット機能
  - Action Cable
* 画像生成機能
  - mini_magick
* スクレイピング機能
  - mechanize
* 投稿検索機能
  - ransack

check ci

## 環境構築系のコマンド
## Docker環境構築
```sh
# docker 起動(初回)
$ docker compose build

# 通常起動
$ docker compose up

# バックグラウンド
$ docker compose up -d

# docker 停止
$ docker compose down

# docker 再起動 gem追加などのとき
$ docker compose restart

```
## docker コマンドの違い
```sh
# docker コンテナを新たに作成して、コマンドを実行する。問題は、コンテナから抜けた後に残ってしまう。コンテナが積み重なっていく。
$ docker compose exec {サービス名} {コマンド}

# docker コンテナを新たに作成するが、自動的に削除するオプションを指定している 
# 環境をクリーンに保てるのがメリット
$ docker compose run --rm {サービス名} {コマンド}
```

## Webサーバーへのアクセス
http://localhost:3010

## Sidekiqへのアクセス
http://localhost:3010/sidekiq

## Rails コマンド一覧
```sh
# gemfile追加
$ docker compose exec web bundle install

# 初回データ作成
$ docker compose exec web rails db:create RAILS_ENV=development

# migrationファイル追加
$ docker compose exec web rails db:migrate RAILS_ENV=development

# rails console使用時
$ docker compose exec web rails c
```

## DB接続 コマンド
```sh
# DBコンテナに入る
$ docker-compose exec db bash

# rootユーザになっている場合
$ mysql -u root -p

```

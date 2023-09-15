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

## Webサーバーへのアクセス
http://localhost:3010

## Rails コマンド一覧
```sh
# gemfile追加
$ docker compose exec web bundle install

# 初回データ作成
$ docker compose exec web rails db:create

# migrationファイル追加
$ docker compose exec web rails db:migrate

# rails console使用時
```

## DB接続 コマンド
```sh
# DBコンテナに入る
$ docker-compose exec db bash

# rootユーザになっている場合
$ mysql -u root -p

```

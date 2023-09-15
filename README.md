## 環境構築系のコマンド
## Docker環境構築
```sh
# docker 起動(初回)
$ docker compose build

# 通常起動
$ docker compose up

# バックグラウンド
$ docker compose up -d

#docker 停止
$ docker compose down

```

## Rails コマンド一覧
```sh
# gemfile追加
$ docker compose exec web bundle install

# 初回データ作成
$ docker compose exec web rails db:create

# migrationファイル追加
$ docker compose exec web rails db:migrate
```

## DB接続 コマンド
```sh

```

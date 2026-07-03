# SQL MCP Server ローカルテスト環境

Docker Compose で SQL Server と SQL MCP Server（Data API Builder）を起動し、VS Code Copilot から MCP ツール経由でデータベースを操作するデモ環境です。

## 前提条件

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

それ以外のインストールは不要です。

## セットアップ

```bash
# 1. リポジトリをクローン
git clone https://github.com/kzk839/sql-mcp-local-demo.git
cd sql-mcp-local-demo

# 2. .env を作成してパスワードを設定
cp .env.example .env
# .env を開いて SA_PASSWORD を入力（8文字以上、大文字・小文字・数字・記号を含む）

# 3. コンテナを起動
docker compose up -d
```

## 使い方

```bash
# test/ フォルダを VS Code で開く
cd test
code .
```

VS Code が開いたら：

1. コマンドパレット（`Ctrl+Shift+P`）→ `MCP: List Servers`
2. `sql-mcp-server` が「実行中」になっていることを確認
3. Copilot チャット（Agent モード）で質問する

```
在庫が10以下の商品を教えて
```

> **重要**: `test/` フォルダを開いてください。リポジトリルートを開くと Copilot が設定ファイルを直接読んでしまい、MCP ツールが使われません。

## 構成

```
├── .env.example         # パスワード設定のテンプレート
├── .gitignore           # .env を除外
├── docker-compose.yml   # SQL Server + MCP Server のコンテナ定義
├── dab-config.json      # DAB（MCP Server）の設定
├── init.sql             # サンプル DB・テーブル・データの初期化
└── test/                # VS Code で開くフォルダ
      └── .vscode/
            └── mcp.json # MCP サーバー接続設定
```

## サンプルデータ

| テーブル | 件数 | 内容 |
|---|---|---|
| Categories | 5 | Electronics / Furniture / Appliances / Office Supplies / Clothing |
| Products | 20 | 在庫0〜350、価格480〜149,900円、廃盤商品あり |
| Reviews | 24 | 評価1〜5、コメントなし（NULL）あり |

## テストプロンプト例

| プロンプト | テスト観点 |
|---|---|
| `全商品の一覧を教えて` | 基本取得 |
| `在庫が10以下の商品は？` | 数値フィルタ |
| `廃盤になっている商品を教えて` | ブールフィルタ |
| `Electronics で5,000円未満の商品は？` | 複合条件 |
| `評価が2以下のレビューは？` | レビューテーブル |
| `商品ID=1の価格を変更して` | RBAC 拒否の確認 |

## 停止

```bash
# コンテナを停止（データは保持、次回 up で再開）
docker compose down

# コンテナとデータを完全削除
docker compose down -v
```

## 注意事項

- **ローカル開発専用**です。本番環境では使用しないでください。
- `mode: development` / `cors: ["*"]` / `anonymous:read` はテスト用の設定です。
- ポートは `127.0.0.1` にバインドされており、LAN からはアクセスできません。

## 参考

- [SQL MCP Server とは（Microsoft Learn）](https://learn.microsoft.com/ja-jp/azure/data-api-builder/mcp/overview)
- [Data API Builder](https://learn.microsoft.com/ja-jp/azure/data-api-builder/)

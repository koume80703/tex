# TeX 文書作成用リポジトリ

## 前処理として

- 環境変数に `$PWD/.bash/` を追加する
- pdf の表示を vscode-pdf という拡張機能を用いて行っているため、そのインストールを行うこと

## 作業ディレクトリ
本リポジトリのルートディレクトリを作業ディレクトリとすること。

## docker image

- paperist/alpine-texlive-ja:latest

初回利用時には

```
$ docker image pull paperist/alpine-texlive-ja:latest
```

を実行し、イメージを取得しておく。

## .tex ファイルのコンパイル

`$PWD/.bash/`以下に tex.sh ファイルがあり、前処理にて環境変数に`$PWD/.bash`を追加しているので、以下の呼び出しを行うことでコンパイルが行われる。

```
$ tex.sh src/TEX_FILE_NAME
```

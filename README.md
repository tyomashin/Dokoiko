# 概要

# 環境

* Xcode 12.3

# 環境構築、導入手順

留意すべき点は以下の通り。

* CLI ツールを開発環境にインストールしておく必要がある。(mint でインストールする)
* Carthage を使用している
* XcodeGen を使用している

## 1. ツールのインストール

本プロジェクトでは、以下のCLIツールを導入している<br>

* SwiftLint
* SwiftGen
* SwiftFormat
* XcodeGen
* Carthage

これらは mint でインストールしている（Mintfile に記載）。<br>


まず、mint をインストールする。

```
$ brew install mint
```

Mintfile に記載している CLI ツールをインストールする。

```
$ mint bootstrap
```


## 2. ライブラリのビルド

本プロジェクトでは、以下のライブラリを使用している。

* RxSwift

ライブラリ管理に Carthage を使用している。<br>

ライブラリをビルドして xcframework を作成する。
プラットフォームは iOS だけにしている。

```
$ mint run carthage update --platform iOS --use-xcframeworks
```

## 3. プロジェクトファイルの生成

XcodeGen を使用して、プロジェクトファイルを自動生成する。<br>

XcodeGen は Mint で入れているため、以下のコマンドで実行できる。<br>

```
$ mint run xcodegen xcodegen generate
```

### 備考

xcodegen のコマンドを実行してから、プロジェクトを開くまでのコマンドを Makefile に記載している。<br>
以下のコマンドを入力するだけで、上記 xcodeGen コマンドが実行される。

```
$ make
```


# プロジェクト

## アーキテクチャ

本プロジェクトでは以下のアーキテクチャパターンを採用している。

* MVVM 

## DI について

テストしやすさを実現するために、以下を考慮している。

* Protcol に対して依存する
* 依存性注入は、inject メソッドを呼び出すことで行う。



# 課題

本プロジェクトで導入できていない課題について整理する。

## 画面遷移ロジックがViewControllerに組み込まれている

Coordinator パターンの適用を考える。

## Model 層にシステムアーキテクチャを適用していない

クリーンアーキテクチャの適用を考える。
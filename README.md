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

まず、Carthage をインストールする。

```
$ brew install carthage
```

次に、ライブラリをビルドして framework を作成する。
プラットフォームは iOS だけにしている。

```
// Swift 5.3.2 に合致するバイナリがない場合はビルドする（--no-use-binaries）
$ carthage update --platform iOS --no-use-binaries
```

**ビルドが失敗する場合**

現在（2021/01/13）、[issue](https://github.com/Carthage/Carthage/issues/3019#issuecomment-665136323)
で議論されているビルドエラーが発生している。<br>

この問題の暫定的な回避策として、[この方法](https://github.com/Carthage/Carthage/issues/3019#issuecomment-665136323)を実施している。

```
$ ./carthage.sh update --platform iOS --no-use-binaries
```

## 3. プロジェクトファイルの生成

XcodeGen を使用して、プロジェクトファイルを自動生成する。<br>

XcodeGen は Mint で入れているため、以下のコマンドで実行できる。<br>

```
$ mint run xcodegen xcodegen generate
```
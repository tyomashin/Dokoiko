# 概要

# 環境

* Xcode 12.3

# 環境と導入

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

本プロジェクトでは Carthage でライブラリ管理をしている。<br>
導入しているライブラリは以下の通り。

* RxSwift
* Alamofire

Carthage によってライブラリをビルドして xcframework を作成する。

```
$ mint run carthage update --platform iOS --use-xcframeworks
```

## 3. プロジェクトファイルの生成

XcodeGen を使用してプロジェクトファイルを自動生成している。<br>

XcodeGen は Mint で入れているため、以下のコマンドで実行できる。<br>

```
$ mint run xcodegen xcodegen generate
```

### 備考

xcodegen のコマンドを実行してから、プロジェクトを開くまでのコマンドを Makefile に記載している。<br>
このため以下のコマンドを入力するだけで、上記 xcodeGen コマンドが実行されてXcodeが自動で立ち上がる。

```
$ make
```


# アーキテクチャ
## GUIアーキテクチャ

MVVM を採用している。

## システムアーキテクチャ

クリーンアーキテクチャを模倣して、MVVM の Model レイヤーをレイヤ分割している。<br>
上位のレイヤーは直下のレイヤーの抽象にのみ依存する。<br>

### Dataレイヤー
* DataStore
* Entity

DataStore は、データ操作や API の実行を行う。<br>
データ操作には、RealmSwift を使用した DB の操作、UserDefaults へのアクセス、
API の実行は Alamofire を使用しているが、このような実装の詳細は上位レイヤーから隠蔽される。<br>
<br>
Entity は、DataStore で扱う静的なオブジェクト（Valueオブジェクト）。<br>
Realmオブジェクトなどが該当する。<br>
上位レイヤーには隠蔽される。（Repository にて、上位レイヤーで扱うオブジェクトとの変換が行われる）<br>


### Domainレイヤー
* Repository
* UseCase
* Model

Repository は、Data レイヤーと Domain レイヤーを結ぶインターフェースの役割を担う。<br>
Repository によって、Data レイヤーの実装は隠蔽される。<br>
また、Entity <-> Model の変換もここで行う。<br>
<br>

UseCase は、アプリ固有のユースケースロジックを担う。<br>
複数の Model（Repository が Entity をユースケース用に変換したオブジェクト） を組み合わせて調整することで実現する。<br>
ここでは Data レイヤーの実装内容を気にする必要はなく、
「import RealmSwift」や「import Alamofire」といった記述が不要（Data レイヤーが依存するライブラリに UseCase は依存しない）。<br>
このため、Dataレイヤーは丸ごと置き換えが可能になる。<br>



## 参考文献

[まだMVC,MVP,MVVMで消耗してるの？ iOS Clean Architectureについて](https://qiita.com/koutalou/items/07a4f9cf51a2d13e4cdc)	


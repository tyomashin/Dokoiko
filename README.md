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

* RxSwift      ... 非同期処理の補助、およびデータバインディング
* Alamofire    ... ネットワーク通信の補助
* OHHTTPStubs  ... APIClientのユニットテスト時にネットワーク通信をスタブ化

Carthage によってライブラリをビルドして xcframework を作成する。

```
$ mint run carthage update --platform iOS --use-xcframeworks
```

なお、Carthage のバージョンは 0.37.0 を使用しているため、
Xcode12 から発生していたframeworkのビルドエラーにも対処できている。<br>

### 参考文献
[XCFrameworksに対応したCarthageを使ってみた](https://laptrinhx.com/xcframeworksni-dui-yingshitacarthagewo-shittemita-2660437151/) <br>


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

### 4. APIキー

本プロジェクトでは API キーを格納した swift ファイルを gitignore に追加している。<br>
このため、以下の形式のファイルをプロジェクトのどこかに格納しておく必要がある。<br>

```swift
enum APIKeys {
    static let RESAS_API_KEY = ""
}
```


# アーキテクチャ
## GUIアーキテクチャ

MVVM を採用している。

## システムアーキテクチャ

クリーンアーキテクチャを採用して、MVVM の Model レイヤを分割している。<br>
アプリ全体のレイヤは以下のように分割している。

* Entities
* UseCases
* InterfaceAdapters
* FrameworksAndDrivers

### Entities
一番内側（下層）のレイヤーで、データ構造・メソッドの集合体。<br>
他のどこのレイヤーにも依存しない。<br>

### UseCases
Entities の一つ上のレイヤー。<br>
アプリ固有のビジネスロジックが記述される。<br>
このレイヤーは、上位層の UI、DB、API などの実装詳細に依存しない。<br>
このため、「import UIKit」「import Alamofire」「import RealmSwift」などのコードを記述してはならない。<br>
UseCase から DB への参照や、API の実行を行う場合は、「InterfaceAdapters」レイヤーを介して行う必要がある。<br>
なお、InterfaceAdapters レイヤーは UseCase レイヤーよりも上位にあるため、UseCase から直接参照することはできず、抽象に依存する形で参照する必要がある（依存性逆転の法則）。<br>

### InterfaceAdapters
UseCase の一つ上のレイヤー。<br>
InterfaceAdapters レイヤーは、UseCase と、この上のレイヤーのつなぎ役、およびレイヤー間のデータ構造の変換層を担っている。<br>

なお、本プロジェクトでは役割に応じて以下の命名を取っている。<br>

* ViewModel ... UI と UseCase の仲介役
* GateWay ... DB の参照や API 実行の仲介役

例えば、DBからデータを取得した後で、Realm オブジェクトと Entity の変換までは、GateWay の責務となる。<br>

### FrameworksAndDrivers
最も外側（上位）のレイヤー。<br>
UI、DB、APIクライアントなどがこのレイヤーに該当する。<br>
UIKit や Alamofire、RealmSwift などのライブラリを使用したロジックはこのレイヤーに記述される。<br>
このレイヤーが最外層にあることで、ネットワーク通信や DB にどんなライブラリを使用していたとしてもビジネスロジックはその詳細に依存することはない。<br>
このためライブラリを置き換える際にも下層レイヤーへの影響が少なくなる。<br>
例えば以下のようなライブラリ、フレームワークを使用する処理もこのレイヤーに置かれる。<br>

* CoreLocation
* GoogleMaps
* NotificationCenter
* CoreBluetooth

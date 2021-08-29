# 概要
App Store にリリースしている「 Dokoiko 」というアプリのプロジェクトです。<br>
本アプリでは以下の機能を提供しています。<br>

* 都市のランダム検索
* 都市のスポット推薦

[Dokoiko (App Store)](https://apps.apple.com/us/app/%E4%BB%8A%E6%97%A5%E3%81%AE%E8%A1%8C%E3%81%8D%E5%85%88%E3%81%8C%E6%B1%BA%E3%81%BE%E3%82%8B-dokoiko/id1581844051)

# 環境

* Xcode 12.4

# 環境と導入
本プロジェクトをビルドするにあたって、環境構築するための手順について記載しています。<br>
環境構築の特徴は以下の通りです。<br>

* CLI ツールを開発環境にインストールしておく必要がある(mint でインストール)
* Carthage を使用している
* XcodeGen を使用している

## 1. ツールのインストール

本プロジェクトでは、以下のCLIツールを導入しています。<br>

* SwiftLint
* SwiftGen
* SwiftFormat
* XcodeGen
* Carthage
* SwiftyMocky

これらは mint でインストールしています（Mintfile に記載）。<br>


mint をインストール

```
$ brew install mint
```

Mintfile に記載している CLI ツールをインストール

```
$ mint bootstrap
```


## 2. ライブラリのビルド

本プロジェクトでは Carthage でライブラリ管理をしています。<br>
導入しているライブラリは以下<Br>

* RxSwift      ... 非同期処理、およびデータバインディング
* Alamofire    ... ネットワーク通信
* OHHTTPStubs  ... APIClientのユニットテスト時にネットワーク通信をスタブ化
* lottie       ... Adobe Effects のアニメーション再生
* Kingfisher   ... 画像キャッシュ

Carthage でライブラリをビルドして xcframework を作成

```
$ mint run carthage update --platform iOS --use-xcframeworks --cache-builds
```

## 3. プロジェクトファイルの生成

XcodeGen を使用してプロジェクトファイルを自動生成しています。<br>

プロジェクトファイルの生成

```
$ mint run xcodegen xcodegen generate
```

### 備考

xcodegen のコマンドを実行してから、プロジェクトを開くまでのコマンドを Makefile に記載しています。<br>
このため以下のコマンドを入力すると、上記 xcodeGen コマンドが実行された後、
Xcodeプロジェクトが自動で立ち上がります。

```
$ make
```

### 4. APIキー

本プロジェクトでは API キーを格納した swift ファイルを gitignore に追加しています。<br>
このため、個々人の環境で以下の内容のファイルを作成しておく必要があります。

```swift
enum APIKeys {
    static let RESAS_API_KEY = ""
    static let GEO_DB_API_KEY = ""
    static let GCP_KEY = ""
    static let LOCAL_SEARCH_API = ""
}
```


# アーキテクチャ
## GUIアーキテクチャ

MVVM を採用

## システムアーキテクチャ

クリーンアーキテクチャを採用して、MVVM の Model レイヤを分割。<br>
アプリ全体のレイヤは以下のように分割している。

* Entities
* UseCases
* InterfaceAdapters
* FrameworksAndDrivers

この名称は、主にクリーンアーキテクチャの説明で使用されている同心円画像から拝借している。<br>

[The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)


### Entities
一番内側（下層）のレイヤーで、データ構造・メソッドの集合体。<br>
他のどのレイヤーにも依存しない。<br>

### UseCases
Entities の一つ上のレイヤー。<br>
アプリ固有のビジネスロジックが記述される。<br>
このレイヤーは、上位層の UI、DB、API などの実装詳細に依存しない。<br>
このため、「import UIKit」「import Alamofire」「import RealmSwift」などのコードを記述してはならない。<br>
UseCase から DB への参照や、API の実行を行う場合は、「InterfaceAdapters」レイヤーを介して行う必要がある。<br>
なお、InterfaceAdapters レイヤーは UseCase レイヤーよりも上位にあるため、
UseCase から直接参照してはならず、抽象に依存する形で参照する必要がある（依存性逆転の法則）。<br>

### InterfaceAdapters
UseCase の一つ上のレイヤー。<br>
InterfaceAdapters レイヤーは、UseCase と、この上のレイヤー（DB, API通信などの実装詳細を担うレイヤー）とのつなぎ役、
およびレイヤー間のデータ構造の変換層を担っている。<br>

なお、本プロジェクトでは役割に応じて以下の命名を取っている。<br>

* ViewModel ... UI と UseCase の仲介役
* GateWay ... DB の参照や API 実行の仲介役

例えば、DB(上位レイヤー)から Realm オブジェクトを取得した後に Entity へデータ構造を変換して UseCase に返却する、
という一連の処理が GateWay の責務となる。<br>

### FrameworksAndDrivers
最も外側（上位）のレイヤー。<br>
UI、DB、APIクライアントなどがこのレイヤーに該当する。<br>
UIKit や Alamofire、RealmSwift などのライブラリを使用したロジックはこのレイヤーに記述される。<br>
このレイヤーが最外層にあることで、ネットワーク通信や DB にどんなライブラリを使用していたとしても、
ビジネスロジックはその詳細に依存することなく記述できる。<br>
このためDBや通信ライブラリを置き換える際にも下層レイヤーへの影響が少なくなる。<br>
例えば以下のようなライブラリ、フレームワークを使用する処理もこのレイヤーに置かれる。<br>

* CoreLocation
* GoogleMaps
* NotificationCenter
* CoreBluetooth

## 画面遷移とDI

アーキテクチャを採用してレイヤ分割した状態から、画面を組み立てるために、
本プロジェクトでは以下の概念を導入している。

* Router

参考：
[VIPER の実装コストを下げるために](https://buildersbox.corp-sansan.com/entry/2020/03/04/110000)

本プロジェクトの Router の特徴は以下の通りである。

* 画面遷移の責務を担う（遷移ロジックを ViewController から切り離す）
* 画面遷移に必要な事前処理も行う（ViewController, ViewModel, UseCase などそれぞれの依存関係を解消してインスタンス化 == DI）
* Router 自体は ViewModel がプロパティとして保持する
* 原則、1画面1Router

# 今後の課題・関心

## VIPER
クリーンアーキテクチャをiOSプロジェクト向けに適用したVIPERアーキテクチャについて調査し、
次のプロジェクトで採用してみたい。
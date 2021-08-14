// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Access {
    /// アクセス
    internal static let title = L10n.tr("Localizable", "access.title")
  }

  internal enum Btn {
    /// 閉じる
    internal static let close = L10n.tr("Localizable", "btn.close")
    /// OK
    internal static let ok = L10n.tr("Localizable", "btn.ok")
    internal enum SearchCondition {
      /// 現在地の近くから探す
      internal static let currentLocation = L10n.tr("Localizable", "btn.searchCondition.currentLocation")
      /// 都道府県から探す
      internal static let prefectures = L10n.tr("Localizable", "btn.searchCondition.prefectures")
      /// 地域をランダムに検索
      internal static let search = L10n.tr("Localizable", "btn.searchCondition.search")
    }
  }

  internal enum Coupon {
    /// クーポン
    internal static let title = L10n.tr("Localizable", "coupon.title")
  }

  internal enum Dialog {
    internal enum Message {
      internal enum Error {
        /// 本クーポンのURLは無効です
        internal static let couponEmpty = L10n.tr("Localizable", "dialog.message.error.couponEmpty")
        /// 検索に失敗しました
        internal static let searchLoading = L10n.tr("Localizable", "dialog.message.error.searchLoading")
        internal enum SearchLoading {
          /// 有効な場所が見つかりませんでした。検索条件を変更してみてください
          internal static let empty = L10n.tr("Localizable", "dialog.message.error.searchLoading.empty")
        }
      }
    }
    internal enum Title {
      /// エラー
      internal static let error = L10n.tr("Localizable", "dialog.title.error")
    }
  }

  internal enum SearchCondition {
    /// 地域の検索方法を選択してください
    internal static let empty = L10n.tr("Localizable", "searchCondition.empty")
    internal enum Area {
      /// エリア
      internal static let title = L10n.tr("Localizable", "searchCondition.area.title")
    }
    internal enum CurrentLocation {
      /// マップをタップするか、現在地ボタンを押して地点を選択してください
      internal static let notice = L10n.tr("Localizable", "searchCondition.currentLocation.notice")
      internal enum Radius {
        /// 半径
        internal static let title = L10n.tr("Localizable", "searchCondition.currentLocation.radius.title")
        /// km
        internal static let unit = L10n.tr("Localizable", "searchCondition.currentLocation.radius.unit")
      }
    }
    internal enum Prefecture {
      /// 都道府県
      internal static let title = L10n.tr("Localizable", "searchCondition.prefecture.title")
    }
  }

  internal enum SearchLoading {
    /// あなたの行き先が\n決定しました！
    internal static let complete = L10n.tr("Localizable", "searchLoading.complete")
    /// Finish !
    internal static let finish = L10n.tr("Localizable", "searchLoading.finish")
    /// あなたに代わって\n今日の行き先を決めています。\nしばらくお待ちください・・・
    internal static let nowLoading = L10n.tr("Localizable", "searchLoading.nowLoading")
    internal enum NowLoading {
      /// Loading
      internal static let empty = L10n.tr("Localizable", "searchLoading.nowLoading.empty")
      /// Loading .
      internal static let one = L10n.tr("Localizable", "searchLoading.nowLoading.one")
      /// Loading . . .
      internal static let three = L10n.tr("Localizable", "searchLoading.nowLoading.three")
      /// Loading . .
      internal static let two = L10n.tr("Localizable", "searchLoading.nowLoading.two")
    }
  }

  internal enum SearchResult {
    internal enum MapTransition {
      /// マップで場所を確認
      internal static let title = L10n.tr("Localizable", "searchResult.mapTransition.title")
    }
    internal enum SpotSearch {
      /// スポットを調べる
      internal static let title = L10n.tr("Localizable", "searchResult.spotSearch.title")
      internal enum Recommend {
        /// アプリの\n推薦スポット
        internal static let title = L10n.tr("Localizable", "searchResult.spotSearch.recommend.title")
      }
      internal enum Web {
        /// Web検索
        internal static let title = L10n.tr("Localizable", "searchResult.spotSearch.web.title")
      }
    }
    internal enum StartTitle {
      /// あなたにオススメする\nドコ行こ？地域は・・・
      internal static let title = L10n.tr("Localizable", "searchResult.startTitle.title")
    }
    internal enum WebSearch {
      /// スポット+ランキング
      internal static let queryDefault = L10n.tr("Localizable", "searchResult.webSearch.queryDefault")
    }
  }

  internal enum SpotDetail {
    /// スポットの詳細
    internal static let title = L10n.tr("Localizable", "spotDetail.title")
    internal enum Address {
      /// 住所: --
      internal static let empty = L10n.tr("Localizable", "spotDetail.address.empty")
    }
    internal enum Link {
      /// 経路案内
      internal static let route = L10n.tr("Localizable", "spotDetail.link.route")
      /// Webサイト
      internal static let web = L10n.tr("Localizable", "spotDetail.link.web")
    }
    internal enum Tel {
      /// TEL: --
      internal static let empty = L10n.tr("Localizable", "spotDetail.tel.empty")
    }
  }

  internal enum SpotList {
    /// スポットが見つかりませんでした
    internal static let empty = L10n.tr("Localizable", "spotList.empty")
    /// スポット
    internal static let title = L10n.tr("Localizable", "spotList.title")
  }

  internal enum Title {
    /// 検索条件
    internal static let searchCondition = L10n.tr("Localizable", "title.searchCondition")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

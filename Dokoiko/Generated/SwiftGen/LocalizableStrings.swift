// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Btn {
    internal enum SearchCondition {
      /// 現在地の近くから探す
      internal static let currentLocation = L10n.tr("Localizable", "btn.searchCondition.currentLocation")
      /// 都道府県から探す
      internal static let prefectures = L10n.tr("Localizable", "btn.searchCondition.prefectures")
      /// 地域をランダムに検索
      internal static let search = L10n.tr("Localizable", "btn.searchCondition.search")
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

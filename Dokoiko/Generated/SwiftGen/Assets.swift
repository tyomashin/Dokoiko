// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let backgroundColor = ColorAsset(name: "backgroundColor")
  internal static let backgroundColorPurple = ColorAsset(name: "backgroundColorPurple")
  internal static let backgroundColorWhite = ColorAsset(name: "backgroundColorWhite")
  internal static let circleColor = ColorAsset(name: "circleColor")
  internal static let primaryColor = ColorAsset(name: "primaryColor")
  internal static let primaryDarkColor = ColorAsset(name: "primaryDarkColor")
  internal static let primaryThinColor = ColorAsset(name: "primaryThinColor")
  internal static let strokeColor = ColorAsset(name: "strokeColor")
  internal static let subPinkColor = ColorAsset(name: "subPinkColor")
  internal static let textColor = ColorAsset(name: "textColor")
  internal static let textColorDisabled = ColorAsset(name: "textColorDisabled")
  internal static let textColorWhite = ColorAsset(name: "textColorWhite")
  internal static let textThinColor = ColorAsset(name: "textThinColor")
  internal static let appImage = ImageAsset(name: "app-image")
  internal static let appLogo = ImageAsset(name: "app-logo")
  internal static let appTitle = ImageAsset(name: "app-title")
  internal static let backButton = ImageAsset(name: "back-button")
  internal static let baselineKeyboardArrowDown = ImageAsset(name: "baseline_keyboard_arrow_down")
  internal static let bigCircle = ImageAsset(name: "big-circle")
  internal static let currentImage = ImageAsset(name: "current_image")
  internal static let loadingCompletion = ImageAsset(name: "loading-completion")
  internal static let mediumCircle = ImageAsset(name: "medium-circle")
  internal static let textImageHistroy = ImageAsset(name: "text-image-histroy")
  internal static let topEmptyState = ImageAsset(name: "top-empty-state")
  internal static let topPrimaryButtonHighlight = ImageAsset(name: "top-primary-button-highlight")
  internal static let topPrimaryButton = ImageAsset(name: "top-primary-button")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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

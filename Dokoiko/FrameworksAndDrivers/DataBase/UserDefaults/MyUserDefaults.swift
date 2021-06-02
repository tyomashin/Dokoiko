//
//  MyUserDefaults.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/03/08.
//

import Foundation

/// PropertyWrapper を使用して UserDefaults へのアクセスを簡略化する
/// 参考：https://swiftsenpai.com/swift/create-the-perfect-userdefaults-wrapper-using-property-wrapper/
@propertyWrapper
internal struct MyUserDefaults<T: Codable> {
    // iOS12 までは、基本型はCodableではないため、構造体でラップしている
    // https://stackoverflow.com/questions/59473051/userdefault-property-wrapper-not-saving-values-ios-versions-below-ios-13
    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }

    private let key: String
    private let defaultValue: T
    private let userdef: UserDefaults

    internal var wrappedValue: T {
        get {
            // UserDefaults にデータがなければデフォルト値を返す
            guard let data = userdef.object(forKey: key) as? Data else {
                return defaultValue
            }

            // データを取得
            let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value?.wrapped ?? defaultValue
        } set {
            let data = try? JSONEncoder().encode(Wrapper(wrapped: newValue))
            userdef.set(data, forKey: key)
        }
    }

    internal init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        userdef = UserDefaults.standard
    }
}

//
//  String+Extension.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/22.
//

import Foundation

extension String {
    /// 文字列が正規表現にマッチするかどうかの判定結果を返す
    /// - Parameter pattern: 正規表現のパターン
    /// - Returns: 判定結果
    func isCheckRegularExpression(pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> Bool {
        // 大文字と小文字を区別しない
        if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
            let resultCount = regex.numberOfMatches(in: self, options: [], range: NSRange(0 ..< count))
            if resultCount > 0 { return true }
        }
        return false
    }
}

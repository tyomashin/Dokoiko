//
//  DateUtils.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/03.
//

import Foundation

/// 日付操作処理を行う
struct DateUtils {
    /// Dateを任意のフォーマット文字列に変換する
    /// - Parameters:
    ///   - date: 対象のDate
    ///   - formatter: フォーマット文字列
    func getFormatterStrJP(date: Date, formatter: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        // 日本に固定
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        // dateFormatter.locale = .current
        // dateFormatter.timeZone = .current
        dateFormatter.dateFormat = formatter
        // Date -> Strigへ変換
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}

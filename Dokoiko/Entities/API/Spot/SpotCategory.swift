//
//  SpotCategory.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/08.
//

import Foundation

/// スポットカテゴリ
enum SpotCategory: Int, CaseIterable {
    // 飲食店
    case restaurant
    // ショッピング
    case shopping
    // レジャー
    case leisure
    // ライフスタイル
    case lifestyle

    // スポット名
    var name: String {
        switch self {
        case .restaurant:
            return "グルメ"
        case .shopping:
            return "ショッピング"
        case .leisure:
            return "レジャー"
        case .lifestyle:
            return "ライフスタイル"
        }
    }
}

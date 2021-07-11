//
//  RecommendSpotEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/08.
//

import Foundation

/// 推薦スポットのEntity
struct RecommendSpotEntity: Codable {
    // 名称
    var name: String?
    // 地点情報
    var lat: Double?
    var lng: Double?
    // ジャンル文字列
    var genre: [String]?
    // 住所
    var address: String?
    // 電話番号
    var tel: String?
    // 画像
    var imageUrl: String?
}

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
    // 距離
    var distanceKM: Double?
    // ジャンル文字列
    var genre: [String]?
    // 住所
    var address: String?
    // 電話番号
    var tel: String?
    // 画像
    var imageUrl: String?
    // クーポン
    var coupons: [RecommendSpotCoupon]?
}

extension RecommendSpotEntity: Equatable {
    static func == (lhs: RecommendSpotEntity, rhs: RecommendSpotEntity) -> Bool {
        if lhs.name == rhs.name,
           lhs.lat == rhs.lat,
           lhs.lng == rhs.lng,
           lhs.distanceKM == rhs.distanceKM,
           lhs.genre == rhs.genre,
           lhs.address == rhs.address,
           lhs.tel == rhs.tel,
           lhs.imageUrl == rhs.imageUrl,
           lhs.coupons == rhs.coupons {
            return true
        } else {
            return false
        }
    }
}

/// 推薦スポットのクーポン
struct RecommendSpotCoupon: Codable, Equatable {
    var name: String?
    var url: String?
}

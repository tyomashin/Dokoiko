//
//  LocationPointEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/25.
//

import Foundation

/// 2点間の地点の距離を計算する
struct LocationPointEntity {
    /// 地点間の距離を求める（メートル）
    /// - Parameters:
    ///   - location: 地点1
    ///   - baseLocation: 地点2
    static func getPointDistance(location: (lat: Double, lng: Double), baseLocation: (lat: Double, lng: Double)) -> Double {
        // 緯度経度をラジアンに変換
        let rlat1 = location.lat * .pi / 180
        let rlng1 = location.lng * .pi / 180
        let rlat2 = baseLocation.lat * .pi / 180
        let rlng2 = baseLocation.lng * .pi / 180
        // 2点の中心角(ラジアン)を求める
        let a =
            sin(rlat1) * sin(rlat2) +
            cos(rlat1) * cos(rlat2) *
            cos(rlng1 - rlng2)
        let rr = acos(a)
        // 地球赤道半径(メートル)
        let earth_radius = 6_371_000.0

        // 2点間の距離(メートル)
        let distance = earth_radius * rr
        return distance
    }
}

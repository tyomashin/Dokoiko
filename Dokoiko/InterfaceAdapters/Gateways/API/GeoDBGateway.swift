//
//  GeoDBGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/27.
//

import Foundation
import RxSwift

/// GeoDB Cities API を呼び出すゲートウェイのプロトコル
/// sourcery: AutoMockable
protocol GeoDBGatewayProtocol {
    /// エリア内に存在する市区情報を取得する
    /// - Parameters:
    ///   - lat: エリアの緯度
    ///   - lng: エリアの軽度
    ///   - radiusKM: エリア半径
    /// - Returns: API結果
    func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>>
}

/// GeoDB Cities API を呼び出すゲートウェイ
struct GeoDBGateway: GeoDBGatewayProtocol {
    private let geoDBAPIClient: GeoDBAPIClientProtocol

    init(geoDBAPIClient: GeoDBAPIClientProtocol) {
        self.geoDBAPIClient = geoDBAPIClient
    }

    /// エリア内に存在する市区情報を取得する
    func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        // APIに渡す位置情報文字列を生成
        var location = ""
        if lat < 0 {
            location = "-" + "\(lat)"
        } else {
            location = "+" + "\(lat)"
        }
        if lng < 0 {
            location += "-" + "\(lng)"
        } else {
            location += "+" + "\(lng)"
        }
        return geoDBAPIClient.getCitiesInArea(location: location, radiusKM: "\(radiusKM)")
    }
}

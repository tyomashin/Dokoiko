//
//  GeoDBUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/28.
//

import Foundation
import RxSwift

/// エリア内の市区情報を取得するユースケースが準拠するプロトコル
/// sourcery: AutoMockable
protocol GeoDBUseCaseProtocol {
    /// エリア内の市区情報を取得する
    func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>>
}

/// エリア内の市区情報を取得するユースケース
class GeoDBUseCase: GeoDBUseCaseProtocol {
    private let geoDBGateway: GeoDBGatewayProtocol

    init(geoDBGateway: GeoDBGatewayProtocol) {
        self.geoDBGateway = geoDBGateway
    }

    /// エリア内の市区情報を取得する
    /// - Parameters:
    ///   - lat: エリアの緯度
    ///   - lng: エリアの経度
    ///   - radiusKM:
    /// - Returns: エリア内の市区情報
    func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        geoDBGateway.getCitiesInArea(lat: lat, lng: lng, radiusKM: radiusKM)
    }
}

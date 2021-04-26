//
//  GeoDBAPIClient.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/26.
//

import Foundation
import RxSwift

/// エリア内の市区を取得するAPIクライアントが準拠するプロトコル
protocol GeoDBAPIClientProtocol: ApiProtocol {
    /// 指定されたエリア内の市区情報を取得する
    func getCitiesInArea(location: String, radiusKM: String) -> Single<ApiResponseEntity<GeoDBCitiesEntity>>
}

/// エリア内の市区を取得するAPIクライアント
struct GeoDBAPIClient: GeoDBAPIClientProtocol {
    /// GeoDBCities APIを使用して、指定されたエリア内の市区情報を取得する
    /// - Parameters:
    ///   - location: エリアの中心緯度経度文字列(フォーマット：±DD.DDDD±DDD.DDDD)
    ///   - radiusKM: エリア半径(KM)
    /// - Returns: APIレスポンス
    func getCitiesInArea(location: String, radiusKM: String) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        request(request: GeoDBAPIRequest.cities(location: location, radiusKM: radiusKM))
    }
}

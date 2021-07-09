//
//  LocalSearchAPIClient.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/08.
//

import Foundation
import RxSwift

/// ローカルサーチAPIでスポットを取得するAPIクライアントが準拠するプロトコル
protocol LocalSearchAPIClientProtocol: ApiProtocol {
    /// 市区コードをもとにスポットを取得する
    /// - Parameters:
    ///   - cityCode: 市区コード
    ///   - startIndex: 全データ中の取得開始位置
    ///   - category: カテゴリ
    func getSpot(
        cityCode: String,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>>
    /// 緯度経度をもとにスポットを取得する
    /// - Parameters:
    ///   - lat: 緯度
    ///   - lng: 経度
    ///   - startIndex: 全データ中の取得開始位置
    ///   - category: カテゴリ
    func getSpot(
        lat: Double,
        lng: Double,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>>
}

/// ローカルサーチAPIでスポットを取得するAPIクライアント
struct LocalSearchAPIClient: LocalSearchAPIClientProtocol {
    /// 市区コードをもとにスポットを取得する
    func getSpot(
        cityCode: String,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>> {
        request(request: LocalSearchAPIRequest.spotWithCity(cityCode: cityCode, startIndex: "\(startIndex)", gc: category.rawValue))
    }

    /// 緯度経度をもとにスポットを取得する
    func getSpot(
        lat: Double,
        lng: Double,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>> {
        request(request: LocalSearchAPIRequest.spotWithLocation(lat: "\(lat)", lng: "\(lng)", startIndex: "\(startIndex)", gc: category.rawValue))
    }
}

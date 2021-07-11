//
//  SpotSearchUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/11.
//

import Foundation
import RxSwift

/// スポットを取得するユースケースが準拠するプロトコル
/// sourcery: AutoMockable
protocol SpotSearchUseCaseProtocol {
    /// 市区コードをもとにスポットを取得する
    /// - Parameters:
    ///   - cityCode: 市区コード
    ///   - startIndex: 全データ中の取得開始位置
    ///   - category: カテゴリ
    func getSpot(
        cityCode: String,
        startIndex: Int,
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>>
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
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>>
}

/// スポットを取得するユースケース
struct SpotSearchUseCase: SpotSearchUseCaseProtocol {
    private let gateway: LocalSearchGatewayProtocol

    init(gateway: LocalSearchGatewayProtocol) {
        self.gateway = gateway
    }

    /// 市区コードをもとにスポットを取得する
    func getSpot(cityCode: String, startIndex: Int, category: SpotCategory) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        gateway
            .getSpot(cityCode: cityCode, startIndex: startIndex, category: category)
    }

    /// 緯度経度をもとにスポットを取得する
    func getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        gateway
            .getSpot(lat: lat, lng: lng, startIndex: startIndex, category: category)
    }
}

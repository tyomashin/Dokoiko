//
//  LocalSearchGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/10.
//

import Foundation
import RxSwift

/// スポット取得の責務を担うゲートウェイが準拠するプロトコル
/// sourcery: AutoMockable
protocol LocalSearchGatewayProtocol {
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

/// スポット取得の責務を担うゲートウェイ
struct LocalSearchGateway: LocalSearchGatewayProtocol {
    private let localSearchClient: LocalSearchAPIClientProtocol

    /// ジャンルのブラックリスト
    private let denyGenreList = [
        "0205001", // コンビニ
        "0205002",
        "0206001", // リサイクル
        "0206002",
        "0206003",
        "0211001" // 通信販売
    ]

    init(localSearchClient: LocalSearchAPIClientProtocol) {
        self.localSearchClient = localSearchClient
    }

    /// 市区コードをもとにスポットを取得する
    func getSpot(cityCode: String, startIndex: Int, category: SpotCategory) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        localSearchClient
            .getSpot(cityCode: cityCode, startIndex: startIndex, category: translate(category: category))
            .map { result -> ApiResponseEntity<[RecommendSpotEntity]> in
                switch result {
                case let .success(response: response):
                    let featureList = self.excludeListWithDenyList(featureList: response.feature ?? [])
                    let entityList = featureList.map { translate(apiObject: $0) }.compactMap { $0 }
                    return .success(response: entityList)

                case let .error(error: error):
                    return .error(error: error)
                }
            }
    }

    /// 緯度経度をもとにスポットを取得する
    func getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        localSearchClient
            .getSpot(lat: lat, lng: lng, startIndex: startIndex, category: translate(category: category))
            .map { result -> ApiResponseEntity<[RecommendSpotEntity]> in
                switch result {
                case let .success(response: response):
                    let featureList = self.excludeListWithDenyList(featureList: response.feature ?? [])
                    let entityList = featureList.map { translate(apiObject: $0) }.compactMap { $0 }
                    return .success(response: entityList)

                case let .error(error: error):
                    return .error(error: error)
                }
            }
    }
}

extension LocalSearchGateway {
    /// APIクライアントで使用する型とEntityとの変換処理
    private func translate(apiObject: LocalSearchAPIFeature) -> RecommendSpotEntity? {
        var lat: Double?
        var lng: Double?

        let coordinates = apiObject.geometry?.coordinates?.components(separatedBy: ",")
        if let lngStr = coordinates?.first {
            lng = Double(lngStr)
        }
        if let latStr = coordinates?.last {
            lat = Double(latStr)
        }

        let genre: [String]? = apiObject.property?.genre?.map(\.name).compactMap { $0 }
        let coupons: [RecommendSpotCoupon]?
        coupons = apiObject.property?.coupon?.map { coupon -> RecommendSpotCoupon in
            let url = coupon.smartPhoneUrl != nil ? coupon.smartPhoneUrl : coupon.pcUrl
            return RecommendSpotCoupon(name: coupon.name, url: url)
        }
        let entity = RecommendSpotEntity(
            name: apiObject.name,
            lat: lat,
            lng: lng,
            genre: genre,
            address: apiObject.property?.address,
            tel: apiObject.property?.tel1,
            imageUrl: apiObject.property?.leadImage,
            coupons: coupons
        )
        return entity
    }

    /// ローカルサーチ用のカテゴリに変換処理
    private func translate(category: SpotCategory) -> LocalSearchAPICategoryType {
        switch category {
        case .restaurant:
            return .restaurant

        case .shopping:
            return .shopping

        case .leisure:
            return .leisure

        case .lifestyle:
            return .lifestyle
        }
    }

    /// ブラックリストに登録しているジャンルのスポットをリストから除外する
    private func excludeListWithDenyList(featureList: [LocalSearchAPIFeature]) -> [LocalSearchAPIFeature] {
        featureList
            .filter { feature in
                for denyGenreCode in denyGenreList {
                    for genre in feature.property?.genre ?? [] {
                        // 除外する条件
                        if genre.code?.contains(denyGenreCode) == true {
                            return false
                        }
                    }
                }
                return true
            }
    }
}

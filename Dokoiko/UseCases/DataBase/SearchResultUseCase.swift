//
//  SearchResultUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/03.
//

import Foundation
import RxSwift

/// 市区検索結果に関する操作を行うユースケースが準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchResultUseCaseProtocol {
    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>>
    /// 市区の検索結果を格納する
    /// - Parameters:
    ///   - prefCode: 都道府県コード
    ///   - cityName: 都市名
    func saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?) -> Single<Result<SearchResultEntity, DataBaseError>>
}

/// 市区検索結果に関する操作を行うユースケース
struct SearchResultUseCase: SearchResultUseCaseProtocol {
    private let gateway: DataBaseGatewayProtocol

    init(gateway: DataBaseGatewayProtocol) {
        self.gateway = gateway
    }

    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>> {
        gateway.getCitySearchResult()
    }

    /// 市区の検索結果を格納する
    func saveCitySearchResult(
        prefCode: Int,
        cityName: String,
        cityCode: String?,
        lat: Double?,
        lng: Double?
    ) -> Single<Result<SearchResultEntity, DataBaseError>> {
        gateway.saveCitySearchResult(prefCode: prefCode, cityName: cityName, cityCode: cityCode, lat: lat, lng: lng)
    }
}

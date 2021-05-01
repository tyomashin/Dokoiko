//
//  DataBaseGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/29.
//

import Foundation
import RxSwift

/// データベースに要求を出すゲートウェイが準拠するプロトコル
protocol DataBaseGatewayProtocol {
    /// 市区の検索結果を格納する。
    /// 格納成功時はそのオブジェクトを返し、失敗時はエラーを返す。
    /// - Parameters:
    ///   - prefCode: 都道府県コード
    ///   - cityName: 市区名
    ///   - lat: 市区の緯度
    ///   - lng: 市区の経度
    func saveCitySearchResult(prefCode: Int, cityName: String, lat: Double?, lng: Double?) -> Single<Result<SearchResultEntity, DataBaseError>>
    /// 市区の緯度経度を変更する。
    /// 成功時はそのオブジェクトを返し、失敗時はエラーを返す。
    /// - Parameters:
    ///   - id: ID
    ///   - lat: 市区の緯度
    ///   - lng: 市区の経度
    func setCityLocation(id: String, lat: Double, lng: Double) -> Single<Result<SearchResultEntity, DataBaseError>>
    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>>
}

/// データベースに要求を出すゲートウェイ
struct DataBaseGateway: DataBaseGatewayProtocol {
    private let database: DatabaseProtocol

    init(database: DatabaseProtocol) {
        self.database = database
    }

    /// 市区の検索結果を格納する
    func saveCitySearchResult(prefCode: Int, cityName: String, lat: Double?, lng: Double?) -> Single<Result<SearchResultEntity, DataBaseError>> {
        database.saveCitySearchResult(prefCode: prefCode, cityName: cityName, lat: lat, lng: lng)
            .map { result -> Result<SearchResultEntity, DataBaseError> in
                switch result {
                case let .success(object):
                    // RealmオブジェクトをEntityに変換する
                    guard let entity = translateSearchResultObject(object: object) else {
                        return .failure(.dataEmptyError)
                    }
                    return .success(entity)

                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    /// 市区の緯度経度を変更する
    func setCityLocation(id: String, lat: Double, lng: Double) -> Single<Result<SearchResultEntity, DataBaseError>> {
        database.setCityLocation(id: id, lat: lat, lng: lng)
            .map { result -> Result<SearchResultEntity, DataBaseError> in
                switch result {
                case let .success(object):
                    // RealmオブジェクトをEntityに変換する
                    guard let entity = translateSearchResultObject(object: object) else {
                        return .failure(.dataEmptyError)
                    }
                    return .success(entity)

                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>> {
        database.getCitySearchResult()
            .map { result -> Result<[SearchResultEntity], DataBaseError> in
                switch result {
                case let .success(objectList):
                    // RealmオブジェクトをEntityに変換してリストに格納
                    // memo: compactMapでnil除去
                    let entityList = objectList.map { translateSearchResultObject(object: $0) }.compactMap { $0 }
                    return .success(entityList)

                case let .failure(error):
                    return .failure(error)
                }
            }
    }
}

/// データ変換
extension DataBaseGateway {
    /// 市区の検索結果オブジェクト：Realm -> Entity
    private func translateSearchResultObject(object: SearchResultObject) -> SearchResultEntity? {
        guard let prefType = PrefectureType.allCases.first(where: { $0.prefCode == object.prefCode }) else {
            return nil
        }
        let entity = SearchResultEntity(
            id: object.id,
            prefCode: object.prefCode,
            prefName: prefType.name,
            cityName: object.cityName,
            lat: object.lat.value,
            lng: object.lng.value
        )
        return entity
    }
}

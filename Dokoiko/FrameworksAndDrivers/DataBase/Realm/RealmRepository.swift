//
//  RealmRepository.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/28.
//

import Foundation
import RealmSwift
import RxSwift

/// DBアクセスを実装する型が準拠するプロトコル
/// sourcery: AutoMockable
protocol DatabaseProtocol {
    /// 市区の検索結果を格納する。
    /// 格納成功時はそのオブジェクトを返し、失敗時はエラーを返す。
    /// - Parameters:
    ///   - prefCode: 都道府県コード
    ///   - cityName: 市区名
    ///   - cityCode: 市区コード
    ///   - lat: 市区の緯度
    ///   - lng: 市区の経度
    func saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?) -> Single<Result<SearchResultObject, DataBaseError>>
    /// 市区の緯度経度を変更する。
    /// 成功時はそのオブジェクトを返し、失敗時はエラーを返す。
    /// - Parameters:
    ///   - id: ID
    ///   - lat: 市区の緯度
    ///   - lng: 市区の経度
    func setCityLocation(id: String, lat: Double, lng: Double) -> Single<Result<SearchResultObject, DataBaseError>>
    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultObject], DataBaseError>>
}

/// Realmを使用してデータベースアクセスを行うクラス
class RealmRepository: DatabaseProtocol {
    /// RxSwiftのスケジューラ
    /// memo: Realm操作はメインスレッドで行うようにする
    private var scheduler: SerialDispatchQueueScheduler {
        MainScheduler.instance
    }

    /// デフォルトRealmを取得する
    private func getRealm() throws -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            throw DataBaseError.openError
        }
    }

    /// 一意なIDを返す
    private func createID() -> String {
        NSUUID().uuidString
    }

    /// 市区の検索結果を格納する
    func saveCitySearchResult(
        prefCode: Int,
        cityName: String,
        cityCode: String?,
        lat: Double?,
        lng: Double?
    ) -> Single<Result<SearchResultObject, DataBaseError>> {
        let result: Result<SearchResultObject, DataBaseError>
        let id = createID()
        let object = SearchResultObject(id: id, prefCode: prefCode, cityName: cityName)
        object.cityCode = cityCode
        object.lat.value = lat
        object.lng.value = lng
        do {
            let realm = try getRealm()
            try realm.write {
                realm.add(object)
            }
            result = .success(object)
        } catch DataBaseError.openError {
            // データベースオープンエラー
            result = .failure(DataBaseError.openError)
        } catch {
            // 書き込みエラー
            result = .failure(DataBaseError.writeError)
        }
        return Single.create { single in
            single(.success(result))
            return Disposables.create()
        }
        .observe(on: scheduler)
    }

    /// 市区の緯度経度を更新する
    func setCityLocation(id: String, lat: Double, lng: Double) -> Single<Result<SearchResultObject, DataBaseError>> {
        // IDに紐づく市区のオブジェクトを取得する
        getCity(id: id).map { result -> Result<SearchResultObject, DataBaseError> in
            switch result {
            // 市区オブジェクトがある場合
            case let .success(city):
                do {
                    // 緯度経度を更新する
                    let realm = try self.getRealm()
                    try realm.write {
                        city.lat.value = lat
                        city.lng.value = lng
                    }
                    return .success(city)
                } catch DataBaseError.openError {
                    return .failure(.openError)
                } catch {
                    return .failure(.writeError)
                }

            case let .failure(error):
                return Result.failure(error)
            }
        }
        .observe(on: scheduler)
    }

    /// 市区情報を返す
    /// - Parameter id: 市区のID
    /// - Returns:
    private func getCity(id: String) -> Single<Result<SearchResultObject, DataBaseError>> {
        Single.create { single in
            do {
                let realm = try self.getRealm()
                let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
                // swiftlint:disable:next first_where
                if let result = realm.objects(SearchResultObject.self).filter(predicate).first {
                    single(.success(.success(result)))
                } else {
                    // データエンプティエラー
                    single(.success(.failure(DataBaseError.dataEmptyError)))
                }
            } catch DataBaseError.openError {
                // データベースオープンエラー
                single(.success(.failure(DataBaseError.openError)))
            } catch {
                single(.success(.failure(DataBaseError.someError(error: error))))
            }
            return Disposables.create()
        }
        .observe(on: scheduler)
    }

    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultObject], DataBaseError>> {
        Single<Result<[SearchResultObject], DataBaseError>>.create { single in
            do {
                let realm = try self.getRealm()
                var results = [SearchResultObject]()
                realm.objects(SearchResultObject.self).forEach {
                    results.append($0)
                }
                single(.success(.success(results)))
            } catch DataBaseError.openError {
                // データベースオープンエラー
                single(.success(.failure(DataBaseError.openError)))
            } catch {
                single(.success(.failure(DataBaseError.someError(error: error))))
            }
            return Disposables.create()
        }
        .observe(on: scheduler)
    }
}

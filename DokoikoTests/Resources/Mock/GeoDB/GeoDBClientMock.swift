//
//  GeoDBClientMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/26.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class GeoDBClientMock: GeoDBAPIClientProtocol {
    func getCitiesInArea(location: String, radiusKM: String) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        var result: ApiResponseEntity<GeoDBCitiesEntity>
        if let object: GeoDBCitiesEntity = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                            fileName: "geoDBCities")
        {
            result = .success(response: object)
        } else {
            result = .error(error: .dataEmptyError)
        }

        return Single.create { single in
            single(.success(result))
            return Disposables.create()
        }
    }
}

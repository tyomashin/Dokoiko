//
//  GeoDBGatewayMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/28.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class GeoDBGatewayMock: GeoDBGatewayProtocol {
    func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        GeoDBClientMock().getCitiesInArea(location: "+\(lat)+\(lng)", radiusKM: "\(radiusKM)")
    }
}

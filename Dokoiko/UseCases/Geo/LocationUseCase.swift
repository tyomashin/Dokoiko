//
//  LocationUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/18.
//

import Foundation
import RxSwift

protocol LocationUseCaseProtocol {
    /// 位置情報が利用可能かどうかを返す
    func getLocationAuth() -> Observable<LocationAuthEntity>
    /// 現在地の緯度経度を返す
    func getCurrentLocation() -> Observable<(lat: Double, lng: Double)>
}

/// 位置情報周りの情報を取得するUseCase
struct LocationUseCase: LocationUseCaseProtocol {
    private let locationGateWay: LocationGatewayProtocol

    init(locationGateWay: LocationGatewayProtocol) {
        self.locationGateWay = locationGateWay
    }

    /// 位置情報が利用可能かどうかを返す
    func getLocationAuth() -> Observable<LocationAuthEntity> {
        locationGateWay.getLocationAuth()
    }

    /// 現在地の緯度経度を返す
    func getCurrentLocation() -> Observable<(lat: Double, lng: Double)> {
        locationGateWay.getCurrentLocation()
    }
}

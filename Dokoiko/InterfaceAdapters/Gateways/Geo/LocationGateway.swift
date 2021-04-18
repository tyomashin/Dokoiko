//
//  LocationGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/18.
//

import CoreLocation
import Foundation
import RxSwift

protocol LocationGatewayProtocol {
    /// 位置情報が許可されているかどうかのストリームを返す
    func getLocationAuth() -> Observable<LocationAuthEntity>
    /// 現在地のストリームを返す
    func getCurrentLocation() -> Observable<(lat: Double, lng: Double)>
}

/// 位置情報周りの情報を上位レイヤーから取得、および必要に応じて
/// 上位レイヤーから取得した情報を下位レイヤーで扱えるようにEntityに変換するゲートウェイ。
struct LocationGateway: LocationGatewayProtocol {
    private let locationManager: LocationManagerProtocol

    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }

    /// 位置情報が許可されているかどうかのストリームを返す
    func getLocationAuth() -> Observable<LocationAuthEntity> {
        locationManager.requestLocationAuth()
            .flatMap { auth in
                makeLocationAuthEntity(auth: auth)
            }
    }

    /// 現在地のストリームを返す
    func getCurrentLocation() -> Observable<(lat: Double, lng: Double)> {
        locationManager.getCurrentLocation()
    }

    /// CoreLocation の位置情報許可状態の列挙型を、本アプリで使用するEntityの型に変換する
    private func makeLocationAuthEntity(auth: CLAuthorizationStatus) -> Observable<LocationAuthEntity> {
        Observable.create { observer in
            switch auth {
            case .notDetermined:
                observer.onNext(.notDetermined)

            case .authorizedAlways, .authorizedWhenInUse:
                observer.onNext(.available)

            default:
                observer.onNext(.noAvailable)
            }
            return Disposables.create()
        }
    }
}

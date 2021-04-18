//
//  LocationManager.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/14.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

/// CLLocationManager を使用して位置情報の取得処理を行うクラスが準拠するプロトコル
protocol LocationManagerProtocol {
    /// 位置情報の利用許可をリクエスト。位置情報の利用許可状態を返す
    func requestLocationAuth() -> Observable<CLAuthorizationStatus>
    /// 現在地の緯度経度のストリームを返す
    func getCurrentLocation() -> Observable<(lat: Double, lng: Double)>
}

/// CLLocationManager を使用して位置情報の取得処理を行うクラス
class LocationManager: NSObject, LocationManagerProtocol {
    // 緯度経度のタプル
    typealias LocationData = (lat: Double, lng: Double)

    static let shared = LocationManager()
    private let clLocationManager = CLLocationManager()

    // 位置情報の利用が許可されているかどうかのストリーム
    private let authLocationRelay = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    private lazy var authLocation: Observable<CLAuthorizationStatus> = authLocationRelay.asObservable()

    // 現在地の緯度経度のストリーム。初期値は東京都
    private let currentLocationRelay = BehaviorRelay<LocationData>(value: (35.684338151185294, 139.76557870506642))
    // nil を除去（参考：https://stackoverflow.com/questions/59337420/convert-publishrelay-to-behaviorrelay-of-optional-element）
    // private lazy var currentLocation: Observable<LocationData> = currentLocationRelay.compactMap { $0 }
    private lazy var currentLocation: Observable<LocationData> = currentLocationRelay.asObservable()

    override private init() {
        super.init()
        clLocationManager.delegate = self
    }

    /// 位置情報の利用許可をリクエスト。位置情報の利用許可状態を返す
    func requestLocationAuth() -> Observable<CLAuthorizationStatus> {
        // 利用許可リクエストを投げる
        clLocationManager.requestAlwaysAuthorization()
        return authLocation
    }

    /// 現在の位置情報を取得する
    func getCurrentLocation() -> Observable<LocationData> {
        // 位置情報の利用許可が取れているかどうか確認
        return currentLocation
    }
}

extension LocationManager: CLLocationManagerDelegate {
    /// アプリの位置情報許可状態が変更した時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authLocationRelay.accept(status)
        switch status {
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
            // 位置情報の取得を開始
            clLocationManager.startUpdatingLocation()

        case .authorizedWhenInUse:
            print("位置情報がアプリ利用時のみ許可されています")
            // 位置情報の取得を開始
            clLocationManager.startUpdatingLocation()

        case .denied, .restricted:
            print("位置情報が利用できません")

        case .notDetermined:
            print("まだ位置情報取得の権限確認を行なっていません")

        default:
            break
        }
    }

    /// 現在地が更新されると呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = manager.location?.coordinate.latitude, let lng = manager.location?.coordinate.longitude {
            currentLocationRelay.accept((lat, lng))
        }
    }
}

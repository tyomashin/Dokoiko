//
//  LocationSearchViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/31.
//

import Foundation
import RxCocoa
import RxSwift

/// 「現在地の近くから検索」のViewModelが準拠するプロトコル
protocol LocationSearchViewModelProtocol {
    /// 検索条件のデータ型
    typealias SelectedCurrentLocationCondition = (lat: Double, lng: Double, radius: Float)
    /// 検索条件
    var searchConditionLocation: Driver<SearchConditionCurrentLocation> { get }
    /// 親ViewModelに渡すための検索条件オブジェクト
    var searchConditionData: SearchConditionCurrentLocation { get }
    /// 現在地の緯度経度
    var currentLocation: Driver<(lat: Double, lng: Double)> { get }
    /// Viewとバインディングする
    /// - Parameters:
    ///   - selectedLocation: 地点選択のイベント
    ///   - selectedRadius: 半径選択のイベント
    func bindViews(selectedLocation: Driver<(lat: Double, lng: Double)>, selectedRadius: Driver<Float>)
    /// 現在選択されている検索条件を返す
    func makeCurrentLocationSearchData() -> SelectedCurrentLocationCondition
}

/// 「現在地の近くから検索」のViewModel
class LocationSearchViewModel: LocationSearchViewModelProtocol {
    private let locationGateway: LocationGatewayProtocol
    private let disposeBag = DisposeBag()
    // 選択された地点
    private var selectedLocation: (lat: Double, lng: Double)?
    // 選択された半径
    private var selectedRadius: Float?

    // 「現在地の近くから検索」の場合の検索条件
    let searchConditionCurrentLocationRelay = BehaviorRelay<SearchConditionCurrentLocation>(value: SearchConditionCurrentLocation())
    var searchConditionLocation: Driver<SearchConditionCurrentLocation> {
        searchConditionCurrentLocationRelay.asDriver()
    }

    /// 親ViewModelに渡すための検索条件オブジェクト
    var searchConditionData: SearchConditionCurrentLocation {
        let data = makeCurrentLocationSearchData()
        var entity = SearchConditionCurrentLocation()
        entity.lat = data.lat
        entity.lng = data.lng
        entity.radius = data.radius
        return entity
    }

    // 現在地の緯度経度
    private let currentLocationRelay = BehaviorRelay<(lat: Double, lng: Double)?>(value: nil)
    var currentLocation: Driver<(lat: Double, lng: Double)> {
        currentLocationRelay.asDriver().compactMap { $0 }
    }

    init(locationGateway: LocationGatewayProtocol) {
        self.locationGateway = locationGateway

        setInitCondition()
    }

    /// 各種初期化処理
    private func setInitCondition() {
        // 現在地を一度だけ取得して検索条件オブジェクトにセット
        // https://qiita.com/sgr-ksmt/items/cc105403fc3dcbd5bd8b
        Observable.of(locationGateway.getCurrentLocation().take(1), Observable.never())
            .concat()
            .subscribe(onNext: { [weak self] location in
                print("hoge, location", location)
                guard let self = self else { return }
                var data = self.searchConditionCurrentLocationRelay.value
                data.lat = location.lat
                data.lng = location.lng
                self.searchConditionCurrentLocationRelay.accept(data)
            })
            .disposed(by: disposeBag)

        // 位置情報の取得
        locationGateway
            .getLocationAuth()
            .flatMap { [weak self] _ -> Observable<(lat: Double, lng: Double)> in
                guard let self = self else {
                    return Observable<(lat: Double, lng: Double)>.never()
                }
                return self.locationGateway.getCurrentLocation()
            }
            .subscribe(onNext: { [weak self] location in
                guard let self = self else { return }
                self.currentLocationRelay.accept(location)
            })
            .disposed(by: disposeBag)
    }

    /// Viewとバインディングする
    func bindViews(selectedLocation: Driver<(lat: Double, lng: Double)>, selectedRadius: Driver<Float>) {
        // 地点が選択された時に呼ばれる
        selectedLocation
            .drive(onNext: { [weak self] location in
                self?.changeLocationInCurrentLocationSearch(location: location)
            })
            .disposed(by: disposeBag)

        // 半径が選択された時に呼ばれる
        selectedRadius
            .drive(onNext: { [weak self] radius in
                self?.changeRadiusInCurrentLocationSearch(radius: radius)
            })
            .disposed(by: disposeBag)
    }

    /// 「現在地の近くから検索」でマップから地点が選択された時の処理
    private func changeLocationInCurrentLocationSearch(location: (lat: Double, lng: Double)) {
        selectedLocation = location
    }

    /// 「現在地の近くから検索」でマップから半径が選択された時の処理
    private func changeRadiusInCurrentLocationSearch(radius: Float) {
        selectedRadius = radius
    }

    /// 「現在地の近くから検索」で選択された条件を返す
    func makeCurrentLocationSearchData() -> SelectedCurrentLocationCondition {
        let lat: Double
        let lng: Double
        let radius: Float

        if let selectedLocation = selectedLocation {
            lat = selectedLocation.lat
            lng = selectedLocation.lng
        } else {
            lat = searchConditionCurrentLocationRelay.value.lat
            lng = searchConditionCurrentLocationRelay.value.lng
        }

        if let selectedRadius = selectedRadius {
            radius = selectedRadius
        } else {
            radius = searchConditionCurrentLocationRelay.value.radius
        }
        return (lat, lng, radius)
    }
}

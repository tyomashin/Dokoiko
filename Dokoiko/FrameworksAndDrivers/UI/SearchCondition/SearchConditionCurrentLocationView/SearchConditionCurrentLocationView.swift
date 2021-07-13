//
//  SearchConditionCurrentLocationView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/21.
//

import GoogleMaps
import RxCocoa
import RxSwift
import UIKit

/// 「現在地の近くから検索」の場合の検索条件
class SearchConditionCurrentLocationView: UIView {
    typealias Location = (lat: Double, lng: Double)
    // 現在地の緯度経度
    private var currentLocation: Location?
    private let disposeBag = DisposeBag()
    // 選択された緯度経度
    fileprivate let selectedLocationRelay = BehaviorRelay<(lat: Double, lng: Double)?>(value: nil)
    // 選択された半径
    fileprivate let selectedRadiusRelay = BehaviorRelay<Float?>(value: nil)
    // マップ上のマーカー
    private var marker = GMSMarker()
    // マップ上のサークル
    private var circle = GMSCircle()

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var radiusView: UIView!
    @IBOutlet weak var radiusTitleLabel: UILabel!
    @IBOutlet weak var radiusValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!

    /// コードからの初期化時に呼ばれる
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustom()
    }

    /// ストーリーボードからの初期化時に呼ばれる
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustom()
    }

    /// 画面初期化時に呼ばれる
    private func initCustom() {
        Bundle(for: SearchConditionCurrentLocationView.self).loadNibNamed("SearchConditionCurrentLocationView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        // UI初期化
        initUI()
        // バインディング
        bindViews()

        mapView.delegate = self
    }

    /// UI初期化
    private func initUI() {
        baseView.backgroundColor = Asset.backgroundColor.color
        radiusView.backgroundColor = Asset.backgroundColor.color
        noticeLabel.textColor = Asset.textThinColor.color
        noticeLabel.font = .systemFont(ofSize: 14)
        noticeLabel.text = L10n.SearchCondition.CurrentLocation.notice
        radiusTitleLabel.textColor = Asset.textThinColor.color
        radiusTitleLabel.font = .systemFont(ofSize: 18)
        radiusTitleLabel.text = L10n.SearchCondition.CurrentLocation.Radius.title
        radiusValueLabel.textColor = Asset.primaryDarkColor.color
        radiusValueLabel.font = .systemFont(ofSize: 18)
        slider.tintColor = Asset.primaryColor.color
        currentButton.backgroundColor = Asset.primaryColor.color
        currentButton.imageView?.contentMode = .scaleAspectFit
        currentButton.contentHorizontalAlignment = .fill
        currentButton.contentVerticalAlignment = .fill
        currentButton.setImage(Asset.currentImage.image, for: .normal)
        currentButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        currentButton.tintColor = Asset.textColorWhite.color
        currentButton.layer.cornerRadius = currentButton.frame.width / 2
        mapView.layer.cornerRadius = 5
        mapViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    }

    /// Viewのイベントを購読
    private func bindViews() {
        // 現在地ボタンタップ時
        currentButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentLocation()
            })
            .disposed(by: disposeBag)

        // スライダーの値変化を購読
        slider.rx.value
            .skip(1)
            .subscribe(onNext: { [weak self] radius in
                self?.updateCircleRadius()
                self?.selectedRadiusRelay.accept(radius)
                self?.updateRadiusLabel()
            })
            .disposed(by: disposeBag)
    }

    /// 検索条件オブジェクトを受け取ってViewを初期化
    fileprivate func setSearchCondition(searchCondition: SearchConditionCurrentLocation) {
        slider.maximumValue = searchCondition.maxRadius
        slider.minimumValue = searchCondition.minRadius
        slider.setValue(searchCondition.radius, animated: false)
        updateRadiusLabel()

        print("hoge", searchCondition)
        updateMapMarker(lat: searchCondition.lat, lng: searchCondition.lng)
    }

    /// 現在地を受け取る
    fileprivate func setCurrentLocation(lat: Double, lng: Double) {
        currentLocation = (lat, lng)
    }

    /// マップ上のマーカーとサークルを更新する
    private func updateMapMarker(lat: Double, lng: Double) {
        marker.map = nil
        circle.map = nil
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let radius = CLLocationDistance(slider.value * 1000)

        let newMarker = GMSMarker(position: position)
        let newCircle = GMSCircle(position: position, radius: radius)
        newCircle.strokeWidth = 0
        newCircle.fillColor = Asset.circleColor.color

        marker = newMarker
        circle = newCircle
        marker.map = mapView
        circle.map = mapView

        moveCamera(lat: lat, lng: lng)
    }

    /// サークルの半径を更新する
    private func updateCircleRadius() {
        circle.radius = CLLocationDistance(slider.value * 1000)
    }

    /// マーカーを現在地の場所に移動させる
    private func moveCurrentLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        updateMapMarker(lat: currentLocation.lat, lng: currentLocation.lng)
        moveCamera(lat: currentLocation.lat, lng: currentLocation.lng)
        // ViewModelに通知
        selectedLocationRelay.accept(currentLocation)
    }

    /// カメラ移動
    private func moveCamera(lat: Double, lng: Double, zoom: Float = 9) {
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        // カメラを移動
        let camera = GMSCameraPosition(target: position, zoom: zoom)
        mapView.animate(to: camera)
    }

    /// 半径ラベル更新
    private func updateRadiusLabel() {
        let radius = Int(slider.value)
        radiusValueLabel.text = "\(radius) " + L10n.SearchCondition.CurrentLocation.Radius.unit
    }
}

extension SearchConditionCurrentLocationView: GMSMapViewDelegate {
    /// マップがタップされた時の処理
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        // マーカーとサークルの位置を移動
        updateMapMarker(lat: coordinate.latitude, lng: coordinate.longitude)
        // 同じズームレベルでカメラ移動
        let zoom = mapView.camera.zoom
        moveCamera(lat: coordinate.latitude, lng: coordinate.longitude, zoom: zoom)
        // ViewModelに通知
        selectedLocationRelay.accept((coordinate.latitude, coordinate.longitude))
    }
}

extension Reactive where Base: SearchConditionCurrentLocationView {
    /// 検索条件オブジェクト
    var searchCondication: Binder<SearchConditionCurrentLocation> {
        Binder(base) { view, condition in
            view.setSearchCondition(searchCondition: condition)
        }
    }

    /// 現在地の緯度経度
    var currentLocation: Binder<(lat: Double, lng: Double)> {
        Binder(base) { view, location in
            view.setCurrentLocation(lat: location.lat, lng: location.lng)
        }
    }

    /// 選択された緯度経度
    var selectedLocation: Driver<Base.Location> {
        base.selectedLocationRelay.asDriver().compactMap { $0 }
    }

    /// 選択された半径
    var selectedRadius: Driver<Float> {
        base.selectedRadiusRelay.asDriver().compactMap { $0 }
    }
}

//
//  RecommendListViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/16.
//

import Foundation
import RxCocoa
import RxSwift

/// 推薦リスト画面のViewModelが準拠するプロトコル
/// sourcery: AutoMockable
protocol RecommendListViewModelProtocol: AnyObject {
    typealias CategoryInfo = (categoryList: [String], selectedIndex: Int)
    typealias SpotEntityData = (spotList: [RecommendSpotEntity], category: SpotCategory)

    /// カテゴリの種類と現在選択されているカテゴリ
    var categoryInfo: Driver<CategoryInfo> { get }
    /// 画面表示するカテゴリのリスト
    var categoryList: Driver<[SpotCategory]> { get }
    /// 画面表示するスポットリスト
    var spotEntityData: Driver<[SpotEntityData]> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
}

/// 推薦リスト画面のViewModel
class RecommendListViewModel: RecommendListViewModelProtocol {
    private weak var view: RecommendListVCProtocol?
    private let router: RecommendListRouterProtocol
    private let searchResult: SearchResultEntity
    private let spotSearchUseCase: SpotSearchUseCaseProtocol
    private let locationGateway: LocationGatewayProtocol

    private let disposeBag = DisposeBag()

    /// カテゴリの種類と現在選択されているカテゴリ
    private let categoryInfoRelay = BehaviorRelay<CategoryInfo?>(value: nil)
    var categoryInfo: Driver<CategoryInfo> {
        categoryInfoRelay.asDriver().compactMap { $0 }
    }

    /// 画面表示するカテゴリのリスト
    private let categoryListRelay = BehaviorRelay<[SpotCategory]?>(value: nil)
    var categoryList: Driver<[SpotCategory]> {
        categoryListRelay.asDriver().compactMap { $0 }
    }

    /// 画面表示するスポットリスト
    private let spotEntityDataRelay = BehaviorRelay<[SpotEntityData]>(value: [])
    var spotEntityData: Driver<[SpotEntityData]> {
        spotEntityDataRelay.asDriver()
    }

    init(
        view: RecommendListVCProtocol,
        router: RecommendListRouterProtocol,
        searchResult: SearchResultEntity,
        spotSearchUseCase: SpotSearchUseCaseProtocol,
        locationGateway: LocationGatewayProtocol
    ) {
        self.view = view
        self.router = router
        self.searchResult = searchResult
        self.spotSearchUseCase = spotSearchUseCase
        self.locationGateway = locationGateway

        categoryListRelay.accept(SpotCategory.allCases)
    }

    /// 情報の初期化
    private func initContents() {
        let spotCategoryNameList = SpotCategory.allCases.map(\.name)
        let spotCategorySelectedIndex = 0
        categoryInfoRelay.accept((spotCategoryNameList, spotCategorySelectedIndex))
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else { return }
        // 閉じるボタン
        view
            .tapCloseButton
            .drive(onNext: { [weak self] in
                self?.router.navigate(to: .close)
            })
            .disposed(by: disposeBag)

        // ページ変化を検知
        view
            .currentPage
            .drive(onNext: { [weak self] index in
                self?.changedPage(index: index)
            })
            .disposed(by: disposeBag)
    }

    /// View読み込み完了後に呼ばれる
    func loadedViews() {
        // Viewとバインディング
        bindViews()

        // 情報の初期化
        initContents()
    }

    /// ページ変化時の処理
    /// - Parameter index: 新しいページ番号
    private func changedPage(index: Int) {
        // 想定しているページの範囲外の場合は何もしない
        guard let pageNum = categoryListRelay.value?.count else {
            return
        }
        if pageNum == 0 || pageNum < index {
            return
        }
        // ページ変化を通知する
        var currentCategoryInfo = categoryInfoRelay.value
        currentCategoryInfo?.selectedIndex = index
        categoryInfoRelay.accept(currentCategoryInfo)

        // カテゴリのスポットを読み込む
        loadSpotEntities(category: SpotCategory.allCases[index])
    }

    /// カテゴリのスポットを読み込む
    private func loadSpotEntities(category: SpotCategory) {
        // すでにスポットを読み込んでいる場合は何もしない
        if spotEntityDataRelay.value.contains(where: { $0.category == category }) {
            return
        }

        // スポットを取得する
        var tmpSingle: Single<ApiResponseEntity<[RecommendSpotEntity]>>?
        // 市区コードからスポットを取得する場合
        if let cityCode = searchResult.cityCode {
            tmpSingle = spotSearchUseCase.getSpot(cityCode: cityCode, startIndex: 1, category: category)
        }
        // 地点からスポットを取得する場合
        else if let lat = searchResult.lat, let lng = searchResult.lng {
            tmpSingle = spotSearchUseCase.getSpot(lat: lat, lng: lng, startIndex: 1, category: category)
        }
        guard let single = tmpSingle else {
            return
        }

        // 直近の現在地を取得
        let locationObservable = Observable
            .of(locationGateway.getCurrentLocation().take(1), Observable.never())
            .concat()
        // 取得したスポットリストに対して、現在地からの距離を格納する
        Observable<ApiResponseEntity<[RecommendSpotEntity]>>
            .combineLatest(locationObservable, single.asObservable(), resultSelector: { [weak self] location, response in
                guard let self = self else { return response }
                switch response {
                case let .success(response: result):
                    // 距離を計算してスポットEntityに格納
                    let newResult = result.map { self.calcSpotDistance(spot: $0, location: location) }
                    // 重複スポットを削除する
                    let narrowSpotList = self.deleteDuplicateSpot(spotList: newResult)
                    return .success(response: narrowSpotList)

                case let .error(error: error):
                    return .error(error: error)
                }
            })
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                var spotData: RecommendListViewModelProtocol.SpotEntityData = (spotList: [], category: category)
                // レスポンスが正常に取得できた場合はそのままスポットリストを返却
                switch response {
                case let .success(response: response):
                    spotData.spotList = response

                // エラー発生時はスポットリストを空にして通知
                case .error:
                    break
                }
                var newSpotDatas = self.spotEntityDataRelay.value
                newSpotDatas.append(spotData)
                self.spotEntityDataRelay.accept(newSpotDatas)
            })
            .disposed(by: disposeBag)
    }

    /// 重複するスポットを削除する
    /// - Parameter spotList: 対象のスポットリスト
    /// - Returns: 重複要素を削除したスポットリスト
    private func deleteDuplicateSpot(spotList: [RecommendSpotEntity]) -> [RecommendSpotEntity] {
        spotList.reduce(into: [RecommendSpotEntity]()) { currentList, newSpot in
            // 重複フラグ
            var isDuplicate = false; var targetIndex: Int?
            // 緯度経度が一致するスポットが存在する場合
            if let index = currentList.firstIndex(where: { $0.lat == newSpot.lat && $0.lng == newSpot.lng }) {
                // 重複フラグを立てる
                isDuplicate = true; targetIndex = index
            }
            // 名前の部分一致を含む場合(かつ距離が100m以内の店舗の場合)
            else if let index = currentList.firstIndex(where: {
                // スポット間の距離が100m以内の場合
                if let firstDistance = $0.distanceKM, let secondDistance = newSpot.distanceKM, fabs(firstDistance - secondDistance) <= 0.1 {
                    // かつ、片方のスポットの名称の一部がもう片方に含まれている場合
                    if let firstName = $0.name?.components(separatedBy: CharacterSet(charactersIn: " 　")).joined(),
                       let secondName = newSpot.name?.components(separatedBy: CharacterSet(charactersIn: " 　")).joined(),
                       firstName.contains(secondName) || secondName.contains(firstName) {
                        return true
                    } else { return false }
                } else { return false }
            }) {
                // 重複フラグを立てる
                isDuplicate = true; targetIndex = index
            }

            if isDuplicate, let index = targetIndex {
                // 画像URLがある方を優先する
                if currentList[index].imageUrl == nil, newSpot.imageUrl != nil { currentList[index] = newSpot }
                // カテゴリが多い方を優先する
                else if let couponCount = currentList[index].coupons?.count, couponCount < (newSpot.coupons?.count ?? 0) { currentList[index] = newSpot }
            }
            // 重複スポットが存在しない場合
            else { currentList.append(newSpot) }
        }
    }

    /// 距離を計算して返す
    /// - Parameters:
    ///   - spot: スポット情報
    ///   - location: 現在地の情報
    /// - Returns: スポットと現在地の距離を格納したスポット情報
    private func calcSpotDistance(spot: RecommendSpotEntity, location: (lat: Double, lng: Double)) -> RecommendSpotEntity {
        guard let spotLat = spot.lat, let spotLng = spot.lng else {
            return spot
        }

        var result = spot
        // 距離を計算する
        let distance = LocationPointEntity.getPointDistance(location: (spotLat, spotLng), baseLocation: location)
        result.distanceKM = distance / 1000

        return result
    }
}

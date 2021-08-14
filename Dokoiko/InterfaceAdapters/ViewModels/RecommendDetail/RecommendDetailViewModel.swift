//
//  RecommendDetailViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/09.
//

import Foundation
import RxCocoa
import RxSwift

/// 推薦詳細画面のViewModelが準拠するプロトコル
protocol RecommendDetailViewModelProtocol: AnyObject {
    typealias SpotInfo = (spot: RecommendSpotEntity, category: SpotCategory)

    /// スポット情報
    var spotEntityData: Driver<SpotInfo> { get }
    /// エラーメッセージ
    var errorMessage: Driver<String> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
}

/// 推薦詳細画面のViewModel
class RecommendDetailViewModel: RecommendDetailViewModelProtocol {
    private weak var view: RecommendDetailVCProtocol?
    private let router: RecommendDetailRouter
    private let spotEntity: RecommendSpotEntity
    private let spotCategory: SpotCategory
    private let disposeBag = DisposeBag()

    /// スポット情報
    private let spotEntityDataRelay = BehaviorRelay<SpotInfo?>(value: nil)
    var spotEntityData: Driver<SpotInfo> {
        spotEntityDataRelay.asDriver().compactMap { $0 }
    }

    /// エラーメッセージ
    private let errorMessageRelay = BehaviorRelay<String?>(value: nil)
    var errorMessage: Driver<String> {
        errorMessageRelay.asDriver().compactMap { $0 }
    }

    init(
        view: RecommendDetailVCProtocol,
        router: RecommendDetailRouter,
        spotEntity: RecommendSpotEntity,
        spotCategory: SpotCategory
    ) {
        self.view = view
        self.router = router
        self.spotEntity = spotEntity
        self.spotCategory = spotCategory

        spotEntityDataRelay.accept((spotEntity, spotCategory))
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else { return }

        // 閉じるボタンタップ時の処理
        view
            .tapCloseButton
            .drive(onNext: { [weak self] in
                self?.router.navigate(to: .close)
            })
            .disposed(by: disposeBag)

        // 戻るボタンタップ時の処理
        view
            .tapBackButton
            .drive(onNext: { [weak self] in
                self?.router.navigate(to: .back)
            })
            .disposed(by: disposeBag)

        // Webサイトボタンタップ時の処理
        view
            .tapWebButton
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                let query = (self.spotEntity.name ?? "") + " " + (self.spotEntity.address ?? "")
                self.router.navigate(to: .transitionWebSearch(query: query))
            })
            .disposed(by: disposeBag)

        // 経路案内ボタンタップ時の処理
        view
            .tapRouteButton
            .drive(onNext: { [weak self] in
                if let lat = self?.spotEntity.lat, let lng = self?.spotEntity.lng {
                    self?.router.navigate(to: .transitionGoogleMap(spotLat: lat, spotLng: lng))
                }
            })
            .disposed(by: disposeBag)

        // クーポンがタップされた時のイベント
        view
            .tapCoupon
            .drive(onNext: { [weak self] coupon in
                guard let self = self else { return }
                guard let couponUrl = coupon.url else {
                    // クーポンが存在しないダイアログ
                    self.errorMessageRelay.accept(L10n.Dialog.Message.Error.couponEmpty)
                    return
                }
                // クーポンのURLへ遷移する
                self.router.navigate(to: .transitionCoupon(urlStr: couponUrl))
            })
            .disposed(by: disposeBag)
    }

    func loadedViews() {
        bindViews()
    }
}

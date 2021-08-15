//
//  RecommendDetailViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/08/15.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class RecommendDetailViewModelTests: XCTestCase {
    var view: RecommendDetailVCProtocolMock!
    var router: RecommendDetailRouterProtocolMock!
    var spotEntity: RecommendSpotEntity!
    var viewModel: RecommendDetailViewModel!
    var spotCategory: SpotCategory!

    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        view = RecommendDetailVCProtocolMock()
        router = RecommendDetailRouterProtocolMock()
        spotEntity = RecommendSpotEntity()
        spotCategory = .leisure

        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        // モックにダミーデータを入れておく
        Given(view, .tapCloseButton(getter: .empty()))
        Given(view, .tapBackButton(getter: .empty()))
        Given(view, .tapWebButton(getter: .empty()))
        Given(view, .tapRouteButton(getter: .empty()))
        Given(view, .tapCoupon(getter: .empty()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        router = nil
        spotEntity = nil
        viewModel = nil
        spotCategory = nil
        disposeBag = nil
        scheguler = nil
    }

    /// 各種ボタンタップイベントのテスト
    func testTapEvent() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        spotEntity = RecommendSpotEntity(name: "Test", lat: 0, lng: 0, distanceKM: 0, genre: [""], address: "address", tel: nil, imageUrl: nil, coupons: [])

        // 戻るボタンタップイベント
        let tapBackButtonEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        Given(view, .tapBackButton(getter: tapBackButtonEvents))

        // 閉じるボタンタップイベント
        let tapCloseButtonEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        Given(view, .tapCloseButton(getter: tapCloseButtonEvents))

        // Webサイトボタンタップイベント
        let tapWebButtonEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        Given(view, .tapWebButton(getter: tapWebButtonEvents))

        // 経路案内ボタンタップイベント
        let tapRouteButtonEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        Given(view, .tapRouteButton(getter: tapRouteButtonEvents))

        // クーポンタップイベント
        let targetCoupon = RecommendSpotCoupon(name: "", url: "https://google.com")
        let tapCouponButtonEvents = scheguler
            .createColdObservable([.next(10, targetCoupon)])
            .asDriver(onErrorJustReturn: targetCoupon)
        Given(view, .tapCoupon(getter: tapCouponButtonEvents))

        viewModel = RecommendDetailViewModel(view: view, router: router, spotEntity: spotEntity, spotCategory: spotCategory)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // 画面遷移が正しく発火しているかどうか
        Verify(router, .navigate(to: .matching { result in
            switch result {
            case .close:
                return true
            default:
                return false
            }
        }))

        Verify(router, .navigate(to: .matching { result in
            switch result {
            case .back:
                return true
            default:
                return false
            }
        }))

        Verify(router, .navigate(to: .matching { result in
            switch result {
            case let .transitionWebSearch(query: query):
                if (self.spotEntity.name! + " " + self.spotEntity.address!) == query {
                    return true
                } else {
                    return false
                }
            default:
                return false
            }
        }))

        Verify(router, .navigate(to: .matching { result in
            switch result {
            case let .transitionGoogleMap(spotLat: spotLat, spotLng: spotLng):
                if spotLat == self.spotEntity.lat!, spotLng == self.spotEntity.lng! {
                    return true
                } else {
                    return false
                }
            default:
                return false
            }
        }))

        Verify(router, .navigate(to: .matching { result in
            switch result {
            case let .transitionCoupon(urlStr: urlStr):
                if urlStr == targetCoupon.url! {
                    return true
                } else {
                    return false
                }
            default:
                return false
            }
        }))
    }

    /// スポット詳細情報の配信テスト
    func testSpotEntity() throws {
        spotEntity = RecommendSpotEntity(name: "Test", lat: 0, lng: 0, distanceKM: 0, genre: [""], address: "address", tel: nil, imageUrl: nil, coupons: [])
        spotCategory = .leisure

        viewModel = RecommendDetailViewModel(view: view, router: router, spotEntity: spotEntity, spotCategory: spotCategory)

        // テスト結果受取用Observerを登録：スポット詳細情報
        let spotDetailEvent = scheguler.createObserver(RecommendDetailViewModelProtocol.SpotInfo.self)
        viewModel
            .spotEntityData
            .drive(spotDetailEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        let element = spotDetailEvent.events[0].value.element!
        XCTAssertEqual(element.spot, spotEntity)
        XCTAssertEqual(element.category, spotCategory)
    }

    /// エラーメッセージのテスト
    func testErrorMessage() throws {
        // クーポンタップイベント
        let targetCoupon = RecommendSpotCoupon(name: "", url: nil)
        let tapCouponButtonEvents = scheguler
            .createColdObservable([.next(10, targetCoupon)])
            .asDriver(onErrorJustReturn: targetCoupon)
        Given(view, .tapCoupon(getter: tapCouponButtonEvents))

        viewModel = RecommendDetailViewModel(view: view, router: router, spotEntity: spotEntity, spotCategory: spotCategory)

        // テスト結果受取用Observerを登録：エラーメッセージ
        let errorMessageEvent = scheguler.createObserver(String.self)
        viewModel
            .errorMessage
            .drive(errorMessageEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        let element = errorMessageEvent.events[0].value.element!
        XCTAssertEqual(element, L10n.Dialog.Message.Error.couponEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

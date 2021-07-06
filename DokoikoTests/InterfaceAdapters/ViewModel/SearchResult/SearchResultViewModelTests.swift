//
//  SearchResultViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/07/06.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class SearchResultViewModelTests: XCTestCase {
    var view: SearchResultVCProtocolMock!
    var router: SearchResultRouterProtocolMock!
    var viewModel: SearchResultViewModel!
    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = SearchResultVCProtocolMock()
        router = SearchResultRouterProtocolMock()
        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        Given(view, .tapCloseButton(getter: .empty()))
        Given(view, .tapMapButton(getter: .empty()))
        Given(view, .tapRecommendButton(getter: .empty()))
        Given(view, .tapWebSearchButton(getter: .empty()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        router = nil
        scheguler = nil
        disposeBag = nil
    }

    /// 閉じるボタンタップテスト
    func testCloseButton() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // ボタンタップイベント
        let tapEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        // Viewモックが返すObservableに指定する
        Given(view, .tapCloseButton(getter: tapEvents))

        // インスタンス生成
        viewModel = SearchResultViewModel(
            view: view,
            router: router,
            isAnimation: false,
            searchResult: SearchResultEntity(id: "", prefCode: 0, prefName: "", cityName: "", lat: nil, lng: nil, date: nil)
        )

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // 閉じるボタンタップ後の画面遷移処理が呼ばれているかどうかのテスト
        Verify(router, .navigate(to: .matching { result in
            if case .close = result {
                return true
            } else {
                return false
            }
        }))
    }

    /// マップボタンタップテスト
    func testMapButton() throws {
        // ボタンタップイベント
        let tapEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        // Viewモックが返すObservableに指定する
        Given(view, .tapMapButton(getter: tapEvents))

        let prefecture = PrefectureType.allCases[1]
        // インスタンス生成
        viewModel = SearchResultViewModel(
            view: view,
            router: router,
            isAnimation: false,
            searchResult: SearchResultEntity(id: "", prefCode: prefecture.prefCode,
                                             prefName: prefecture.name, cityName: "city", lat: nil, lng: nil, date: nil)
        )

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // ボタンタップ後の画面遷移処理が呼ばれているかどうかのテスト
        Verify(router, .navigate(to: .matching { result in
            // クエリが正しく設定されているか
            if case let .transitionGoogleMap(query: query) = result, query == prefecture.name + "city" {
                return true
            } else {
                return false
            }
        }))
    }

    /// Web検索ボタンタップテスト
    func testWebButton() throws {
        // ボタンタップイベント
        let tapEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        // Viewモックが返すObservableに指定する
        Given(view, .tapWebSearchButton(getter: tapEvents))

        let prefecture = PrefectureType.allCases[1]
        let searchResult = SearchResultEntity(id: "", prefCode: prefecture.prefCode,
                                              prefName: prefecture.name, cityName: "city", lat: 30, lng: 100, date: Date())
        // インスタンス生成
        viewModel = SearchResultViewModel(
            view: view,
            router: router,
            isAnimation: false,
            searchResult: searchResult
        )

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // ボタンタップ後の画面遷移処理が呼ばれているかどうかのテスト
        Verify(router, .navigate(to: .matching { result in
            // 検索クエリが正しく設定されているかどうかチェック
            if case let .transitionWebBrowser(query: query) = result,
               query == L10n.SearchResult.WebSearch.queryDefault + "+" + prefecture.name + "city"
            {
                return true
            } else {
                return false
            }
        }))
    }

    /// 推薦ボタンタップテスト
    func testRecommendButton() throws {
        // ボタンタップイベント
        let tapEvents = scheguler
            .createColdObservable([.next(10, ())])
            .asDriver(onErrorJustReturn: ())
        // Viewモックが返すObservableに指定する
        Given(view, .tapRecommendButton(getter: tapEvents))

        let prefecture = PrefectureType.allCases[1]
        let searchResult = SearchResultEntity(id: "", prefCode: prefecture.prefCode,
                                              prefName: prefecture.name, cityName: "city", lat: 30, lng: 100, date: Date())
        // インスタンス生成
        viewModel = SearchResultViewModel(
            view: view,
            router: router,
            isAnimation: false,
            searchResult: searchResult
        )

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // ボタンタップ後の画面遷移処理が呼ばれているかどうかのテスト
        Verify(router, .navigate(to: .matching { result in
            // 検索結果が正しく設定されているかどうか
            if case let .recommendSpot(searchResult: entity) = result, entity == searchResult {
                return true
            } else {
                return false
            }
        }))
    }

    /// アニメーション情報のテスト
    func testAnimationData() throws {
        let prefecture = PrefectureType.allCases[1]
        let searchResult = SearchResultEntity(id: "", prefCode: prefecture.prefCode,
                                              prefName: prefecture.name, cityName: "city", lat: 30, lng: 100, date: Date())
        // インスタンス生成
        viewModel = SearchResultViewModel(
            view: view,
            router: router,
            isAnimation: true,
            searchResult: searchResult
        )

        // テスト結果受取用Observerを登録：アニメーションデータ
        let animationDataEvent = scheguler.createObserver((isAnimation: Bool, cityName: String).self)
        viewModel
            .animationData
            .drive(animationDataEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        let element = animationDataEvent.events[0].value.element
        XCTAssertEqual(element?.isAnimation, true)
        XCTAssertEqual(element?.cityName, "city")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

//
//  MainViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/06/06.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class MainViewModelTests: XCTestCase {
    var view: MainVCProtocolMock!
    var router: MainRouterProtocolMock!
    var viewModel: MainViewModelProtocol!
    var searchResultUseCase: SearchResultUseCaseProtocolMock!
    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MainVCProtocolMock()
        router = MainRouterProtocolMock()
        searchResultUseCase = SearchResultUseCaseProtocolMock()
        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        Given(view, .itemSelected(getter: .empty()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        router = nil
        searchResultUseCase = nil
        scheguler = nil
        disposeBag = nil
    }

    /// 検索ボタンがタップされた時に画面遷移できるかどうかのテスト
    func testTapSearchButton() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // ボタンタップイベント発火用
        let tapEvents = scheguler
            .createColdObservable([.next(10, ()),
                                   .next(20, ())])
            .asDriver(onErrorJustReturn: ())

        // 検索結果リストイベントのテスト用
        let searchResultEvents = scheguler.createObserver([SearchResultEntity].self)

        let searchEntity = [SearchResultEntity(id: "", prefCode: 0, prefName: "", cityName: "", lat: nil, lng: nil, date: nil)]
        let searchResults = Single<Result<[SearchResultEntity], DataBaseError>>.create { single in
            single(.success(.success(searchEntity)))
            return Disposables.create()
        }

        // view のモックが返す Observable を定義
        Given(view, .tapSearchButton(getter: tapEvents))
        // ViewModel が依存する UseCase が返す Observable を定義
        Given(searchResultUseCase, .getCitySearchResult(willReturn: searchResults))

        // ViewModelをモックで初期化
        viewModel = MainViewModel(view: view, router: router, searchResultUseCase: searchResultUseCase)

        // ViewModelの値をテスト用オブザーバーで購読
        viewModel
            .searchHistoryList
            .drive(searchResultEvents)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // routerの画面遷移メソッドが２回呼ばれていることを確認
        Verify(router, 2, .navigate(to: .value(.searchCondition)))

        // 意図した検索結果リストが返されるかどうか確認
        XCTAssertEqual(searchResultEvents.events.last?.value.element, searchEntity)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

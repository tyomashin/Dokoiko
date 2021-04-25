//
//  WikiDataClientMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class WikiDataClientMock: WikiDataAPIClientProtocol {
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        var result: ApiResponseEntity<WikiDataResponseEntity>
        // ローカルのJsonファイルをデコードしてオブジェクト初期化
        if let object: WikiDataResponseEntity = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                                 fileName: "wikiData" + wikiCode)
        {
            result = .success(response: object)
        } else {
            result = .error(error: .dataEmptyError)
        }

        return Single.create { single in
            single(.success(result))
            return Disposables.create()
        }
    }
}

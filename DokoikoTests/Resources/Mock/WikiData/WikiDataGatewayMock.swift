//
//  WikiDataGatewayMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class WikiDataGatewayMock: WikiDataGatewayProtocol {
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        return WikiDataClientMock().getWikiData(wikiCode: wikiCode)
    }
}

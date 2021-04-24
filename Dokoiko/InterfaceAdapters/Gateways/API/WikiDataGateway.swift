//
//  WikiDataGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/07.
//

import Foundation
import RxSwift

protocol WikiDataGatewayProtocol {
    /// Wikiコードに合致する情報を取得する
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>>
}

/// Wikiデータ取得の責務を担うゲートウェイ
struct WikiDataGateway: WikiDataGatewayProtocol {
    private let wikiDataClient: WikiDataAPIClientProtocol

    init(wikiDataClient: WikiDataAPIClientProtocol) {
        self.wikiDataClient = wikiDataClient
    }

    /// Wikiコードに合致する情報を取得する
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        wikiDataClient.getWikiData(wikiCode: wikiCode)
    }
}

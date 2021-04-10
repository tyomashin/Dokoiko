//
//  WikiDataUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/08.
//

import Foundation
import RxSwift

protocol WikiDataUseCaseProtocol {
    /// Wikiコードに合致するWikiデータをデータソースから取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponseEntity<WikiDataResponseEntity>>
}

/// WikiデータをGatewayから取得する責務を担うユースケース
struct WikiDataUseCase: WikiDataUseCaseProtocol {
    private let wikiDataGateway: WikiDataGatewayProtocol

    init(wikiDataGateway: WikiDataGatewayProtocol) {
        self.wikiDataGateway = wikiDataGateway
    }

    /// Wikiコードに合致するWikiデータをGatewayから取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponseEntity<WikiDataResponseEntity>> {
        wikiDataGateway.getWikiData(wikiCode: wikiCode)
    }
}

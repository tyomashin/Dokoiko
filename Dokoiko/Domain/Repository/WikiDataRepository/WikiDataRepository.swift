//
//  WikiDataRepository.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/07.
//

import Foundation
import RxSwift

protocol WikiDataRepositoryProtocol {
    /// Wikiコードに合致する情報を取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>>
}

/// Wikiデータ取得の責務を担うリポジトリ
struct WikiDataRepository: WikiDataRepositoryProtocol {
    private let wikiDataStore: WikiDataStoreProtocol

    init(wikiDataStore: WikiDataStoreProtocol) {
        self.wikiDataStore = wikiDataStore
    }

    /// Wikiコードに合致する情報を取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>> {
        wikiDataStore.getWikiData(wikiCode: wikiCode)
    }
}

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
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>>
}

/// Wikiデータをデータソースから取得する責務を担うユースケース
struct WikiDataUseCase: WikiDataUseCaseProtocol {
    private let wikiDataRepository: WikiDataRepositoryProtocol

    init(wikiDataRepository: WikiDataRepositoryProtocol) {
        self.wikiDataRepository = wikiDataRepository
    }

    /// Wikiコードに合致するWikiデータをデータソースから取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>> {
        wikiDataRepository.getWikiData(wikiCode: wikiCode)
    }
}

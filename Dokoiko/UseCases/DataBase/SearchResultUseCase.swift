//
//  SearchResultUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/03.
//

import Foundation
import RxSwift

/// 市区検索結果に関する操作を行うユースケースが準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchResultUseCaseProtocol {
    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>>
}

/// 市区検索結果に関する操作を行うユースケース
struct SearchResultUseCase: SearchResultUseCaseProtocol {
    private let gateway: DataBaseGatewayProtocol

    init(gateway: DataBaseGatewayProtocol) {
        self.gateway = gateway
    }

    /// 市区の検索結果一覧を取得する
    func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>> {
        gateway.getCitySearchResult()
    }
}

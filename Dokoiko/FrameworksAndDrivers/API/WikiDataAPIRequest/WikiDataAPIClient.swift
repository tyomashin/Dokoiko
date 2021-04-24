//
//  WikiDataAPIClient.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation
import RxSwift

/// Wikiデータを取得するAPIクライアントが準拠するプロトコル
protocol WikiDataAPIClientProtocol: ApiProtocol {
    /// 指定されたwikiCodeに合致するWikiデータをAPIで取得する
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>>
}

/// Wiki API を実行してWikiデータを取得するAPIクライアント
struct WikiDataAPIClient: WikiDataAPIClientProtocol {
    /// 指定されたwikiCodeに合致するWikiデータをAPIで取得する
    /// - Parameter wikiCode: 対象のWikiデータコード
    /// - Returns: API実行結果のストリーム
    func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        request(request: WikiDataAPIRequest.entityData(entityCode: wikiCode))
    }
}

//
//  WikiDataStore.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation
import RxSwift

/// Wikiデータを取得するDataStoreが準拠するプロトコル
protocol WikiDataStoreProtocol: ApiProtocol {
    /// 指定されたwikiCodeに合致するWikiデータをAPIで取得する
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>>
}

/// Wiki API を実行してWikiデータを取得するデータストア
struct WikiDataStore: WikiDataStoreProtocol {
    /// 指定されたwikiCodeに合致するWikiデータをAPIで取得する
    /// - Parameter wikiCode: 対象のWikiデータコード
    /// - Returns: API実行結果のストリーム
    func getWikiData(wikiCode: String) -> Observable<ApiResponse<WikiDataResponseEntity>> {
        request(request: WikiDataRequest.entityData(entityCode: wikiCode))
    }
}

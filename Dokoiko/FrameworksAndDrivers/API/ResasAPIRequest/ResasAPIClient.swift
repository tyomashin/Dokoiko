//
//  ResasAPIClient.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/19.
//

import Foundation
import RxSwift

/// 市区町村情報を取得するAPIクライアントが準拠するプロトコル
protocol ResasAPIClientProtocol: ApiProtocol {
    /// 指定された都道府県に存在する市区町村情報をRESAS-APIで取得する
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>
}

/// 市区町村情報を取得するAPIクライアント
struct ResasAPIClient: ResasAPIClientProtocol {
    /// 指定された都道府県に存在する市区町村情報をRESAS-APIで取得する
    /// - Parameter prefCode: 対象の都道府県コード
    /// - Returns: API実行結果
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        request(request: ResasAPIRequest.cities(prefCode: prefCode))
    }
}

//
//  ResasGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/21.
//

import Foundation
import RxSwift

/// APIを呼び出して市区町村一覧を取得するGatewayが準拠するプロトコル
/// sourcery: AutoMockable
protocol ResasGatewayProtocol {
    /// 都道府県コードに合致する市区町村一覧を取得する
    /// - Parameter prefCode: 都道府県コード
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>
}

/// APIを呼び出して市区町村一覧を取得するGateway
struct ResasGateway: ResasGatewayProtocol {
    private let resasAPIClient: ResasAPIClientProtocol

    init(resasAPIClient: ResasAPIClientProtocol) {
        self.resasAPIClient = resasAPIClient
    }

    /// 都道府県コードに合致する市区町村一覧を取得する
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        resasAPIClient.getMunicipalities(prefCode: prefCode)
    }
}

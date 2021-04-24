//
//  ResasUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/22.
//

import Foundation
import RxSwift

/// 市区町村を取得するユースケースが準拠するプロトコル
protocol ResasUseCaseProtocol {
    /// 都道府県内の市区一覧を取得する
    /// - Parameter prefCode: 都道府県コード
    func getCitiesInPrefecture(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>
}

/// 市区町村を取得するユースケース
struct ResasUseCase: ResasUseCaseProtocol {
    private let resasGateway: ResasGatewayProtocol

    init(resasGateway: ResasGatewayProtocol) {
        self.resasGateway = resasGateway
    }

    /// 都道府県内の市区一覧を取得する
    /// - Parameter prefCode: 都道府県コード
    func getCitiesInPrefecture(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        resasGateway.getMunicipalities(prefCode: prefCode)
            .map { result -> ApiResponseEntity<ResasMunicipalityResponseEntity> in
                switch result {
                case let .success(response: response):
                    // 市区町村から、市区のみに絞り込んで返す
                    return .success(response: filterCities(entity: response))

                case let .error(error: error):
                    return .error(error: error)
                }
            }
    }

    /// 市区町村から市区のみに絞り込む
    private func filterCities(entity: ResasMunicipalityResponseEntity) -> ResasMunicipalityResponseEntity {
        var result = ResasMunicipalityResponseEntity()
        result.result = entity.result?.filter {
            // 政令指定都市は除外
            if $0.bigCityFlag == "2" { return false }
            // 末尾に「町」or「村」がついている場合は除外
            return $0.cityName?.isCheckRegularExpression(pattern: "^.*[^町村]$") ?? false
        }
        return result
    }
}

//
//  ResasGatewayMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class ResasGatewayMock: ResasGatewayProtocol {
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        return ResasClientMock().getMunicipalities(prefCode: prefCode)
    }
}

//
//  ResasClientMock.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import Foundation
import RxSwift

/// モック
class ResasClientMock: ResasAPIClientProtocol {
    func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        var result: ApiResponseEntity<ResasMunicipalityResponseEntity>
        if let object: ResasMunicipalityResponseEntity = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                                          fileName: "resasMunicipalityPrefCode" + prefCode)
        {
            result = .success(response: object)
        } else {
            result = .error(error: .dataEmptyError)
        }

        return Single.create { single in
            single(.success(result))
            return Disposables.create()
        }
    }
}

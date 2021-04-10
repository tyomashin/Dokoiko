//
//  WikiDataRequest.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Alamofire
import Foundation

enum WikiDataRequest {
    // APIのエンドポイント定義
    case entityData(entityCode: String)
}

extension WikiDataRequest: ApiRequestProtocol {
    var baseURL: URL? {
        URL(string: "https://www.wikidata.org/" + path)
    }

    var path: String {
        switch self {
        case let .entityData(entityCode: entityCode):
            return "wiki/Special:EntityData/" + entityCode
        }
    }

    var method: HTTPMethod {
        switch self {
        case .entityData:
            return .get
        }
    }

    var headers: [String: String] {
        switch self {
        case .entityData:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
}

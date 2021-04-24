//
//  ResasAPIRequest.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/19.
//

import Alamofire
import Foundation

/// APIのエンドポイント定義
/// 仕様：https://opendata.resas-portal.go.jp/docs/api/v1/cities.html
enum ResasAPIRequest {
    // 市区町村一覧を取得する
    case cities(prefCode: String)
}

extension ResasAPIRequest: ApiRequestProtocol {
    var baseURL: URL? {
        URL(string: "https://opendata.resas-portal.go.jp" + path)
    }

    var path: String {
        switch self {
        case .cities:
            return "/api/v1/cities"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] {
        switch self {
        case .cities:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-API-KEY": APIKeys.RESAS_API_KEY
            ]
        }
    }

    var queryParameters: [String: String] {
        switch self {
        case let .cities(prefCode):
            return [
                "prefCode": prefCode
            ]
        }
    }
}

//
//  GeoDBAPIRequest.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/26.
//

import Alamofire
import Foundation

/// APIのエンドポイント定義
enum GeoDBAPIRequest {
    /// エリア内の市区を取得する
    case cities(location: String, radiusKM: String)
}

extension GeoDBAPIRequest: ApiRequestProtocol {
    var baseURL: URL? {
        URL(string: "https://wft-geo-db.p.rapidapi.com" + path)
    }

    var path: String {
        switch self {
        case .cities:
            return "/v1/geo/cities"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] {
        [
            "x-rapidapi-key": APIKeys.GEO_DB_API_KEY,
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com"
        ]
    }

    var queryParameters: [String: String] {
        switch self {
        case let .cities(location: location, radiusKM: radiusKM):
            return [
                "location": location,
                "limit": "10",
                "radius": radiusKM,
                "distanceUnit": "KM"
            ]
        }
    }
}

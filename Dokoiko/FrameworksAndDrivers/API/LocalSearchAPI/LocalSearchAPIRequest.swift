//
//  LocalSearchAPIRequest.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/09.
//

import Alamofire
import Foundation

/// APIのエンドポイント定義
enum LocalSearchAPIRequest {
    /// 市区コードをもとにスポットを取得する
    case spotWithCity(cityCode: String, startIndex: String, gc: String)
    /// 緯度経度をもとにスポットを取得する
    case spotWithLocation(lat: String, lng: String, startIndex: String, gc: String)
}

extension LocalSearchAPIRequest: ApiRequestProtocol {
    var baseURL: URL? {
        URL(string: "https://map.yahooapis.jp" + path)
    }

    var path: String {
        "/search/local/V1/localSearch"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] {
        [:]
    }

    var queryParameters: [String: String] {
        var parameters: [String: String] = [
            "appid": APIKeys.LOCAL_SEARCH_API,
            "output": "json",
            "results": "100",
            "sort": "-rating"
        ]
        switch self {
        case let .spotWithCity(cityCode: cityCode, startIndex: startIndex, gc: gc):
            parameters["ac"] = cityCode
            parameters["start"] = startIndex
            parameters["gc"] = gc

        case let .spotWithLocation(lat: lat, lng: lng, startIndex: startIndex, gc: gc):
            parameters["lat"] = lat
            parameters["lon"] = lng
            parameters["dist"] = "5"
            parameters["start"] = startIndex
            parameters["gc"] = gc
        }

        return parameters
    }
}

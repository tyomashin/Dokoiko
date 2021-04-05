//
//  ApiRequest.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Alamofire
import Foundation

/// APIリクエスト情報を定義する型が準拠するプロトコル
protocol ApiRequestProtocol {
    /// 基底URL
    var baseURL: URL? { get }
    /// 基底URLの末尾につけるパス
    var path: String { get }
    /// リクエストメソッド
    var method: HTTPMethod { get }
    /// リクエストヘッダー
    var headers: [String: String] { get }
}

//
//  ApiProtocol.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Alamofire
import Foundation
import RxSwift

/// APIリクエストを定義する構造体が準拠する必要のあるプロトコル
protocol ApiProtocol {
    typealias Request = ApiRequestProtocol
    /// APIリクエストを実行する
    /// - Parameter request: リクエストの詳細
    func request<T: Codable>(request: Request) -> Single<ApiResponseEntity<T>>
    /// Alamofire の引数に渡す URLRequest インスタンスを生成して返す
    /// - Parameter request: リクエストの詳細
    func getDefaultUrlRequest(request: Request) -> URLRequest?
}

/// プロトコルのデフォルト実装を定義
extension ApiProtocol {
    /// APIリクエストを実行する
    func request<T: Codable>(request: Request) -> Single<ApiResponseEntity<T>> {
        Single.create { single in
            // 引数のリクエスト情報から URLRequest インスタンスを生成
            guard let req = getDefaultUrlRequest(request: request) else {
                // リクエストが生成できなければエラーを返す
                single(.success(.error(error: .requestUrlError)))
                return Disposables.create()
            }
            // Alamofire によってAPIを実行
            AF.request(req).response { response in
                // ステータスコードを確認
                let statusCode = ApiStatusCodeEntity(statusCode: response.response?.statusCode)
                switch statusCode {
                case .success:
                    // レスポンスのJsonをデコードして構造体にマッピングする
                    let result = ApiResponseDecoder<T>(jsonData: response.data)
                    if case let .success(entity: entity) = result {
                        single(.success(.success(response: entity)))
                    } else {
                        single(.success(.error(error: .dataEmptyError)))
                    }
                // ステータスコードエラー
                case .someError:
                    single(.success(.error(error: .statusCodeError(statusCode: statusCode))))
                }
            }
            return Disposables.create()
        }
    }

    /// リクエスト情報からURLRequestオブジェクトを生成する
    func getDefaultUrlRequest(request: Request) -> URLRequest? {
        guard let url = request.baseURL else {
            return nil
        }
        var newUrl: URL? = url
        // クエリパラメータがある場合
        if !request.queryParameters.isEmpty {
            // urlにクエリパラメータを付与
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            var queryItems = [URLQueryItem]()
            request.queryParameters.forEach { queryParameter in
                queryItems.append(URLQueryItem(name: queryParameter.key, value: queryParameter.value))
            }
            components?.queryItems = queryItems
            newUrl = components?.url
        }
        print("hoge ... request", newUrl)
        if let newUrl = newUrl {
            var req = URLRequest(url: newUrl)
            req.method = request.method
            req.allHTTPHeaderFields = request.headers
            return req
        }

        return nil
    }
}

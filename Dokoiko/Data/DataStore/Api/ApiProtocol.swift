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
    /// APIリクエストを実行する
    /// - Parameter request: リクエストの詳細
    func request<T: ApiRequestProtocol, U: Codable>(request: T) -> Observable<ApiResponse<U>>
    /// Alamofire の引数に渡す URLRequest インスタンスを生成して返す
    /// - Parameter request: リクエストの詳細
    func getDefaultUrlRequest<T: ApiRequestProtocol>(request: T) -> URLRequest?
}

/// プロトコルのデフォルト実装を定義
extension ApiProtocol {
    /// APIリクエストを実行する
    func request<T: ApiRequestProtocol, U: Codable>(request: T) -> Observable<ApiResponse<U>> {
        Observable.create { observer in
            // 引数のリクエスト情報から URLRequest インスタンスを生成
            guard let req = getDefaultUrlRequest(request: request) else {
                // リクエストが生成できなければエラーを返す
                observer.onNext(.error(error: .requestUrlError))
                observer.onCompleted()
                return Disposables.create()
            }
            // Alamofire によってAPIを実行
            AF.request(req).response { response in
                // ステータスコードを確認
                let statusCode = ApiStatusCode(statusCode: response.response?.statusCode)
                switch statusCode {
                case .success:
                    // レスポンスのJsonをデコードして構造体にマッピングする
                    let result = ApiResponseDecoder<U>(jsonData: response.data)
                    if case let .success(entity: entity) = result {
                        observer.onNext(.success(response: entity))
                    } else {
                        observer.onNext(.error(error: .dataEmptyError))
                    }
                // ステータスコードエラー
                case .someError:
                    observer.onNext(.error(error: .statusCodeError(statusCode: statusCode)))
                }
                // ストリームを終了させる
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /// リクエスト情報からURLRequestオブジェクトを生成する
    func getDefaultUrlRequest<T: ApiRequestProtocol>(request: T) -> URLRequest? {
        guard let url = request.baseURL else {
            return nil
        }
        var req = URLRequest(url: url)
        req.method = request.method
        req.allHTTPHeaderFields = request.headers
        return req
    }
}

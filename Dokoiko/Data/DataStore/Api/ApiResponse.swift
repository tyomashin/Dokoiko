//
//  ApiResponse.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation

/// APIのレスポンスを表現する型
enum ApiResponse<T: Codable> {
    /// 成功時。関連値にCodableオブジェクトが渡される
    case success(response: T)
    /// エラー時。関連値にエラー種別が渡される
    case error(error: ApiError)
}

/// APIのエラー種別
enum ApiError {
    /// リクエストURLが不正
    case requestUrlError
    /// ステータスコードが不正
    case statusCodeError(statusCode: ApiStatusCode)
    /// ステータスコードは200だったが、レスポンスデータのデコードに失敗
    case dataEmptyError
}

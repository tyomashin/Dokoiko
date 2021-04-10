//
//  ApiResponseDecoder.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation

/// APIレスポンスデータのデコードを担う型
enum ApiResponseDecoder<T: Codable> {
    /// デコード成功時。関連値にはデータマッピング後のオブジェクトが渡される
    case success(entity: T)
    /// デコード失敗時
    case failure

    /// Jsonデータをデコードするイニシャライザ
    init(jsonData: Data?) {
        guard let jsonData = jsonData else {
            self = .failure
            return
        }
        let entity = try? JSONDecoder().decode(T.self, from: jsonData)
        if let entity = entity {
            // デコードに成功した場合
            self = .success(entity: entity)
        } else {
            // デコードに失敗した場合
            self = .failure
        }
    }
}

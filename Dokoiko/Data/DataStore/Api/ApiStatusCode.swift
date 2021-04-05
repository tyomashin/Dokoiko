//
//  ApiStatusCodeError.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation

/// APIステータスコード
enum ApiStatusCode {
    case success
    case someError

    init(statusCode: Int?) {
        guard let statusCode = statusCode else {
            self = .someError
            return
        }
        if statusCode == 200 {
            self = .success
        } else {
            self = .someError
        }
    }
}

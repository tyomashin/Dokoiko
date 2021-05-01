//
//  DataBaseError.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/28.
//

import Foundation

/// データベース操作のエラー定義
enum DataBaseError: Error {
    case openError
    case writeError
    case dataEmptyError
    case someError(error: Error)
}

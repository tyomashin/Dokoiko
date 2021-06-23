//
//  LoadingState.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/14.
//

import Foundation

/// ローディング状態
enum LoadingState {
    // ローディング中
    case loading
    // 完了
    case completion
    // エラー
    case error(message: String)
    // 何もしていない
    case idle
}

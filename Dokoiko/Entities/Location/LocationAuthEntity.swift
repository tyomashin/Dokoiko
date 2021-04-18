//
//  LocationAuthEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/18.
//

import Foundation

/// 位置情報の許可状態に関する種別
enum LocationAuthEntity {
    // まだ位置情報の利用許可を取っていない場合
    case notDetermined
    // 位置情報が利用できない場合
    case noAvailable
    // 利用できる場合
    case available
}

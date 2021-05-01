//
//  SearchResultEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/30.
//

import Foundation

/// 検索した市区の情報を格納するエンティティ
struct SearchResultEntity {
    let id: String
    let prefCode: Int
    let prefName: String
    let cityName: String
    var lat: Double?
    var lng: Double?
}

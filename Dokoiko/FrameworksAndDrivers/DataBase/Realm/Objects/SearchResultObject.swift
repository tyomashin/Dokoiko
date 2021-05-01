//
//  SearchResultObject.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/28.
//

import Foundation
import RealmSwift

/// 市区の検索結果を格納する
class SearchResultObject: Object {
    /// 一意なID
    @objc dynamic var id: String = ""
    // 都道府県コード
    @objc dynamic var prefCode = 0
    // 市区名
    @objc dynamic var cityName = ""
    // 市区を表す緯度経度
    let lat = RealmOptional<Double>()
    let lng = RealmOptional<Double>()
    // 検索日時
    @objc dynamic var date = Date()

    convenience init(id: String, prefCode: Int, cityName: String) {
        self.init()
        self.id = id
        self.prefCode = prefCode
        self.cityName = cityName
    }

    override static func primaryKey() -> String? {
        "id"
    }
}

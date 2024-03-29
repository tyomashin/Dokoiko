//
//  LocalSearchAPIResponse.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/08.
//

import Foundation

/// ローカルサーチAPIで取得したスポット一覧が格納される
struct LocalSearchAPIResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case resultInfo = "ResultInfo"
        case feature = "Feature"
    }

    var resultInfo: LocalSearchAPIResultInfo?
    var feature: [LocalSearchAPIFeature]?
}

/// ローカルサーチAPIのまとめ情報
struct LocalSearchAPIResultInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case start = "Start"
        case status = "Status"
    }

    // 件数
    var count: Int?
    // 全データからの取得開始位置
    var start: Int?
    // ステータスコード
    var status: Int?
}

/// ローカルサーチAPIのスポット概要
struct LocalSearchAPIFeature: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "Count"
        case gid = "Start"
        case name = "Name"
        case geometry = "Geometry"
        case category = "Category"
        case property = "Property"
    }

    var id: String?
    var gid: String?
    var name: String?
    var geometry: LocalSearchAPIGeometry?
    var category: [String]?
    var property: LocalSearchAPIProperty?
}

/// ローカルサーチAPIのスポット地点情報
struct LocalSearchAPIGeometry: Codable {
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case coordinates = "Coordinates"
    }

    var type: String?
    var coordinates: String?
}

/// ローカルサーチAPIのスポットプロパティ
struct LocalSearchAPIProperty: Codable {
    enum CodingKeys: String, CodingKey {
        case uid = "Uid"
        case cassetteId = "CassetteId"
        case address = "Address"
        case tel1 = "Tel1"
        case genre = "Genre"
        case leadImage = "LeadImage"
        case coupon = "Coupon"
    }

    var uid: String?
    var cassetteId: String?
    var address: String?
    var tel1: String?
    var genre: [LocalSearchAPIGenre]?
    var leadImage: String?
    var coupon: [LocalSearchAPICoupon]?
}

/// ローカルサーチAPIのスポットジャンル
struct LocalSearchAPIGenre: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
    }

    var code: String?
    var name: String?
}

/// ローカルサーチAPIのクーポン
struct LocalSearchAPICoupon: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case pcUrl = "PcUrl"
        case smartPhoneUrl = "SmartPhoneUrl"
    }

    var name: String?
    var pcUrl: String?
    var smartPhoneUrl: String?
}

/// カテゴリ
enum LocalSearchAPICategoryType: String {
    // 飲食店
    case restaurant = "01"
    // ショッピング
    case shopping = "0204,0207,0209"
    // レジャー
    case leisure = "0302,0303,0305005"
    // ライフスタイル
    case lifestyle = "0418"
}

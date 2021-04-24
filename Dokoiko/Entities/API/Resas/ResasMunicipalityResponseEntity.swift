//
//  ResasMunicipalityResponseEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/21.
//

import Foundation

/// 市区町村情報が格納される
struct ResasMunicipalityResponseEntity: Codable {
    var result: [ResasMunicipalityDetail]?
}

/// 市区町村詳細
struct ResasMunicipalityDetail: Codable {
    var prefCode: Int?
    var cityCode: String?
    var cityName: String?
    var bigCityFlag: String?
}

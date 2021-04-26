//
//  GeoDBCitiesEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/26.
//

import Foundation

/// エリア内の市区情報が格納される
struct GeoDBCitiesEntity: Codable {
    var data: [GeoDBCityData]?
}

struct GeoDBCityData: Codable {
    var id: Int?
    var wikiDataId: String?
    var name: String?
    var regionCode: String?
    var latitude: Double?
    var longitude: Double?
    var population: Int?
    var distance: Double?
}

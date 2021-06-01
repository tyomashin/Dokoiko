//
//  SearchConditionType.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/17.
//

import Foundation

/// 検索条件種別
enum SearchConditionType: CaseIterable {
    // 都道府県から検索
    case prefectures
    // 現在地の近くから検索
    case currentLocation

    var title: String {
        switch self {
        case .prefectures:
            return L10n.Btn.SearchCondition.prefectures

        case .currentLocation:
            return L10n.Btn.SearchCondition.currentLocation
        }
    }

    var tag: Int {
        switch self {
        case .prefectures:
            return 0

        case .currentLocation:
            return 1
        }
    }
}

/// 「都道府県から検索」の場合の検索条件
struct SearchConditionPrefectures: Codable {
    // 表示するエリアリスト
    var regionBlockList: [RegionalBlockType]
    // 選択されているエリアインデックス
    var selectedRegionBlockIndex: Int
    // 表示する都道府県リスト
    var prefecturesList: [PrefectureType]
    // 選択されている都道府県インデックス
    var selectedPrefectureIndex: Int
}

/// 「現在地の近くから検索」の場合の検索条件
struct SearchConditionCurrentLocation: Codable {
    // 緯度経度(初期値は東京都)
    var lat: Double = 35.68154948744106
    var lng: Double = 139.76763864162797
    // 半径(km)
    var radius: Float = 10
    // 最大・最小の半径
    var maxRadius: Float = 30
    var minRadius: Float = 5
}

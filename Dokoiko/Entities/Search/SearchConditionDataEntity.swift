//
//  SearchConditionDataEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/01.
//

import Foundation

/// 検索条件種別とデータを紐付けた型
enum SearchConditionDataEntity {
    // 都道府県から検索
    case prefectures(condition: SearchConditionPrefectures)
    // 現在地の近くから検索
    case currentLocation(condition: SearchConditionCurrentLocation)
}

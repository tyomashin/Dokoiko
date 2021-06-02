//
//  AppData.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/03/11.
//

import Foundation

/// UserDefaults に格納したデータへのアクセスを提供する
internal enum AppData {
    /// 検索条件キャッシュ
    enum SearchCondition {
        /// 「都道府県から検索」の場合の検索条件
        @MyUserDefaults(key: "searchConditionPrefectures", defaultValue: nil)
        internal static var searchConditionPrefectures: SearchConditionPrefectures?
    }

    /// 初回起動フラグ
    @MyUserDefaults(key: "firstLaunchFlag", defaultValue: true)
    internal static var firstLaunchFlag: Bool
}

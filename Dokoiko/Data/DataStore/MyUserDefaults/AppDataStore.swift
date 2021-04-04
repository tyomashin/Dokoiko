//
//  AppDataStore.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/03/11.
//

import Foundation

/// UserDefaults に格納したデータへのアクセスを提供する
internal enum AppDataStore {
    /// 初回起動フラグ
    @MyUserDefaults(key: "FirstLaunchFlag", defaultValue: true)
    internal static var firstLaunchFlag: Bool
}

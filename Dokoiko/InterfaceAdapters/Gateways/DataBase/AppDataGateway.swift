//
//  AppDataGateway.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/20.
//

import Foundation
import RxSwift

/// 一時保存しているデータへのアクセスを要求するゲートウェイが準拠するプロトコル
protocol AppDataGatewayProtocol {
    /// 初回起動フラグ
    var firstLaunchFlag: Single<Bool> { get }
    /// 「都道府県から検索」の場合の検索条件
    var searchConditionPrefectures: Single<SearchConditionPrefectures?> { get }
}

/// 一時保存しているデータへのアクセスを要求するゲートウェイ
struct AppDataGateway: AppDataGatewayProtocol {
    /// 初回起動フラグ
    var firstLaunchFlag: Single<Bool> {
        Single.create { single in
            single(.success(AppData.firstLaunchFlag))
            return Disposables.create()
        }
    }

    /// 「都道府県から検索」の場合の検索条件
    var searchConditionPrefectures: Single<SearchConditionPrefectures?> {
        Single.create { single in
            single(.success(AppData.SearchCondition.searchConditionPrefectures))
            return Disposables.create()
        }
    }
}

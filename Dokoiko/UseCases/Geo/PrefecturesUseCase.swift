//
//  PrefecturesUseCase.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/19.
//

import Foundation
import RxSwift

/// 都道府県情報を取得する型のプロトコル
protocol PrefecturesUseCaseProtocol {
    // 都道府県データのタプル
    typealias PrefectureData = (prefCode: Int, name: String)
    /// エリア一覧を取得する
    func getRegionBlockList() -> Single<[String]>
    /// エリア内の都道府県一覧を取得する
    func getPrefecturesInRegion(index: Int) -> Single<[PrefectureData]>
}

/// 都道府県情報を取得するユースケース
struct PrefecturesUseCase: PrefecturesUseCaseProtocol {
    /// エリア一覧を取得する
    func getRegionBlockList() -> Single<[String]> {
        Single.create { single in
            single(.success(RegionalBlockType.allCases.map(\.name)))
            return Disposables.create()
        }
    }

    /// エリア内の都道府県一覧を取得する
    /// - Parameter index: エリアのインデックス
    /// - Returns: エリア内の都道府県一覧
    func getPrefecturesInRegion(index: Int) -> Single<[PrefectureData]> {
        Single.create { single in
            single(.success(RegionalBlockType.allCases[index].prefectures.map { ($0.prefCode, $0.name) }))
            return Disposables.create()
        }
    }
}

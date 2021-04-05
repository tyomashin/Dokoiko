//
//  WikiDataEntity.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/05.
//

import Foundation

/// WikiDataStore で扱うEntity。
/// WikiデータAPIから取得したオブジェクトが格納される
struct WikiDataResponseEntity: Codable {
    /// entities 配下はWikiコードを動的Keyに持つ
    var entities: [String: WikiDataDetails]?
}

struct WikiDataDetails: Codable {
    /// Wikiコードに紐づくデータのタイトル情報
    var labels: WikiDataJapanLabel?
}

struct WikiDataJapanLabel: Codable {
    /// 日本語タイトルの情報
    var ja: WikiDataLabelDetail?
}

struct WikiDataLabelDetail: Codable {
    /// 言語
    var language: String?
    /// タイトル
    var value: String?
}

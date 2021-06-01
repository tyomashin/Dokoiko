//
//  PrefectureType.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/18.
//

import Foundation

/// 都道府県の情報を定義
enum PrefectureType: Int, CaseIterable, Codable {
    case Hokkaido
    case Aomori
    case Iwate
    case Miyagi
    case Akita
    case Yamagata
    case Fukushima
    case Ibaraki
    case Tochigi
    case Gunma
    case Saitama
    case Chiba
    case Tokyo
    case Kanagawa
    case Niigata
    case Toyama
    case Ishikawa
    case Fukui
    case Yamanashi
    case Nagano
    case Gifu
    case Shizuoka
    case Aichi
    case Mie
    case Shiga
    case Kyoto
    case Osaka
    case Hyogo
    case Nara
    case Wakayama
    case Tottori
    case Shimane
    case Okayama
    case Hiroshima
    case Yamaguchi
    case Tokushima
    case Kagawa
    case Ehime
    case Kochi
    case Fukuoka
    case Saga
    case Nagasaki
    case Kumamoto
    case Oita
    case Miyazaki
    case Kagoshima
    case Okinawa
}

extension PrefectureType {
    /// 都道府県名
    var name: String {
        switch self {
        case .Hokkaido:
            return "北海道"
        case .Aomori:
            return "青森県"
        case .Iwate:
            return "岩手県"
        case .Miyagi:
            return "宮城県"
        case .Akita:
            return "秋田県"
        case .Yamagata:
            return "山形県"
        case .Fukushima:
            return "福島県"
        case .Ibaraki:
            return "茨城県"
        case .Tochigi:
            return "栃木県"
        case .Gunma:
            return "群馬県"
        case .Saitama:
            return "埼玉県"
        case .Chiba:
            return "千葉県"
        case .Tokyo:
            return "東京都"
        case .Kanagawa:
            return "神奈川県"
        case .Niigata:
            return "新潟県"
        case .Toyama:
            return "富山県"
        case .Ishikawa:
            return "石川県"
        case .Fukui:
            return "福井県"
        case .Yamanashi:
            return "山梨県"
        case .Nagano:
            return "長野県"
        case .Gifu:
            return "岐阜県"
        case .Shizuoka:
            return "静岡県"
        case .Aichi:
            return "愛知県"
        case .Mie:
            return "三重県"
        case .Shiga:
            return "滋賀県"
        case .Kyoto:
            return "京都府"
        case .Osaka:
            return "大阪府"
        case .Hyogo:
            return "兵庫県"
        case .Nara:
            return "奈良県"
        case .Wakayama:
            return "和歌山県"
        case .Tottori:
            return "鳥取県"
        case .Shimane:
            return "島根県"
        case .Okayama:
            return "岡山県"
        case .Hiroshima:
            return "広島県"
        case .Yamaguchi:
            return "山口県"
        case .Tokushima:
            return "徳島県"
        case .Kagawa:
            return "香川県"
        case .Ehime:
            return "愛媛県"
        case .Kochi:
            return "高知県"
        case .Fukuoka:
            return "福岡県"
        case .Saga:
            return "佐賀県"
        case .Nagasaki:
            return "長崎県"
        case .Kumamoto:
            return "熊本県"
        case .Oita:
            return "大分県"
        case .Miyazaki:
            return "宮崎県"
        case .Kagoshima:
            return "鹿児島県"
        case .Okinawa:
            return "沖縄県"
        }
    }

    /// 都道府県コード
    var prefCode: Int {
        switch self {
        case .Hokkaido:
            return 1

        case .Aomori:
            return 2

        case .Iwate:
            return 3

        case .Miyagi:
            return 4

        case .Akita:
            return 5

        case .Yamagata:
            return 6

        case .Fukushima:
            return 7

        case .Ibaraki:
            return 8

        case .Tochigi:
            return 9

        case .Gunma:
            return 10

        case .Saitama:
            return 11

        case .Chiba:
            return 12

        case .Tokyo:
            return 13

        case .Kanagawa:
            return 14

        case .Niigata:
            return 15

        case .Toyama:
            return 16

        case .Ishikawa:
            return 17

        case .Fukui:
            return 18

        case .Yamanashi:
            return 19

        case .Nagano:
            return 20

        case .Gifu:
            return 21

        case .Shizuoka:
            return 22

        case .Aichi:
            return 23

        case .Mie:
            return 24

        case .Shiga:
            return 25

        case .Kyoto:
            return 26

        case .Osaka:
            return 27

        case .Hyogo:
            return 28

        case .Nara:
            return 29

        case .Wakayama:
            return 30

        case .Tottori:
            return 31

        case .Shimane:
            return 32

        case .Okayama:
            return 33

        case .Hiroshima:
            return 34

        case .Yamaguchi:
            return 35

        case .Tokushima:
            return 36

        case .Kagawa:
            return 37

        case .Ehime:
            return 38

        case .Kochi:
            return 39

        case .Fukuoka:
            return 40

        case .Saga:
            return 41

        case .Nagasaki:
            return 42

        case .Kumamoto:
            return 43

        case .Oita:
            return 44

        case .Miyazaki:
            return 45

        case .Kagoshima:
            return 46

        case .Okinawa:
            return 47
        }
    }
}

//
//  RegionalBlockType.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/18.
//

import Foundation

/// 地域ブロック
enum RegionalBlockType: Int, CaseIterable, Codable {
    case Hokkaido
    case Tohoku
    case Kanto
    case Chubu
    case Kinki
    case Chugoku
    case Shikoku
    case Kyushu
}

extension RegionalBlockType {
    /// 地域名
    var name: String {
        switch self {
        case .Hokkaido:
            return "北海道"
        case .Tohoku:
            return "東北"
        case .Kanto:
            return "関東"
        case .Chubu:
            return "中部"
        case .Kinki:
            return "近畿"
        case .Chugoku:
            return "中国"
        case .Shikoku:
            return "四国"
        case .Kyushu:
            return "九州"
        }
    }

    /// 地域に含まれる都道府県
    var prefectures: [PrefectureType] {
        switch self {
        case .Hokkaido:
            return [.Hokkaido]

        case .Tohoku:
            return [.Aomori, .Iwate, .Akita, .Miyagi, .Yamagata, .Fukushima]

        case .Kanto:
            return [.Ibaraki, .Tochigi, .Gunma, .Saitama, .Chiba, .Tokyo, .Kanagawa]

        case .Chubu:
            return [.Yamanashi, .Nagano, .Niigata, .Toyama, .Ishikawa, .Fukui, .Shizuoka, .Aichi, .Gifu]

        case .Kinki:
            return [.Mie, .Shiga, .Kyoto, .Osaka, .Hyogo, .Nara, .Wakayama]

        case .Chugoku:
            return [.Tottori, .Shimane, .Okayama, .Hiroshima, .Yamaguchi]

        case .Shikoku:
            return [.Kagawa, .Ehime, .Tokushima, .Kochi]

        case .Kyushu:
            return [.Fukuoka, .Saga, .Nagasaki, .Kumamoto, .Oita, .Miyazaki, .Kagoshima, .Okinawa]
        }
    }
}

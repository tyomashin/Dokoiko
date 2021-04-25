//
//  JSONDecoder+Extension.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/25.
//

import Foundation

extension JSONDecoder {
    /// ローカルのJsonファイルからCodableな型にデコードする
    func decodeFromJsonFile<T: Codable>(bundle: Bundle, fileName: String) -> T? {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        let object = try? decode(T.self, from: jsonData)
        return object
    }
}

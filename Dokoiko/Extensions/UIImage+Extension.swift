//
//  UIImage+Extension.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/12.
//

import Foundation
import UIKit

extension UIImage {
    /// 単色の色画像を生成する
    static func colorImage(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

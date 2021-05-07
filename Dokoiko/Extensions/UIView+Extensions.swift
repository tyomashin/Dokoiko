//
//  UIView+Extensions.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/02.
//

import Foundation
import UIKit

extension UIView {
    /// 任意の角を丸くする
    /// https://qiita.com/hachinobu/items/dc2ff32fa2be6b78ea86
    /// - Parameters:
    ///   - corners: 任意の角
    ///   - radius: 半径
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }

    /// 背景に影をつける
    /// 参考：https://stackoverflow.com/questions/39624675/add-shadow-on-uiview-using-swift-3
    ///      https://xyk.hatenablog.com/entry/2017/03/19/023639
    /// - Parameter scale:
    func dropShadow(scale: Bool = true, color: UIColor = .lightGray) {
        // サブレイヤーをViewの境界でクリップしないようにする
        layer.masksToBounds = false
        // 影の色
        layer.shadowColor = color.cgColor
        // 影の濃さ
        layer.shadowOpacity = 0.5
        // 影の方向
        layer.shadowOffset = CGSize(width: 1, height: 1)
        // 影のぼかし量
        layer.shadowRadius = 5
        // 影の形状を明示して処理を高速化
        // 参考：https://developer.apple.com/documentation/quartzcore/calayer/1410771-shadowpath
        // layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        // 処理の高速化のため
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

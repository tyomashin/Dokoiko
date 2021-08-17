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
    /// - Parameters:
    ///   - color: 影の色
    ///   - opacity: 影の濃さ
    ///   - shadowOffset: 影の方向 (左上からどれだけずらすかの指定)
    func dropShadow(
        color: UIColor = .lightGray,
        opacity: Float = 0.8,
        shadowOffset: CGSize = .init(width: 1, height: 1)
    ) {
        // サブレイヤーをViewの境界でクリップしないようにする
        layer.masksToBounds = false
        // 影の色
        layer.shadowColor = color.cgColor
        // 影の濃さ
        layer.shadowOpacity = opacity
        // 影の方向
        layer.shadowOffset = shadowOffset
        // 影のぼかし量
        layer.shadowRadius = 5
        // 影の形状を明示して処理を高速化
        // 参考：https://developer.apple.com/documentation/quartzcore/calayer/1410771-shadowpath
        // layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        // 処理の高速化のため
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    /// 枠をつける
    func addBorderFrame(color: UIColor, borderWidth: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }

    /// 親Viewいっぱいに広げる制約をつける
    func addFitConstraintOnParent(parentView: UIView) {
        // Autosizingを無効にする
        translatesAutoresizingMaskIntoConstraints = false
        // 親Viewいっぱいになるように制約をつける
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true

        layoutIfNeeded()
    }

    /// 背景にブラー効果を与える
    func addBackgroundBlur(style: UIBlurEffect.Style = .dark) {
        // すでにブラーが追加されている場合は何もしない
        if subviews.first(where: { ($0 as? UIVisualEffectView) != nil }) != nil {
            return
        }
        let blurEffect = UIBlurEffect(style: style)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = frame
        addSubview(visualEffectView)
        visualEffectView.addFitConstraintOnParent(parentView: self)
        sendSubviewToBack(visualEffectView)
    }
}

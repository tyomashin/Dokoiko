//
//  RecommendTabViewCell.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/18.
//

import UIKit

/// 推薦画面のタブViewセル
class RecommendTabViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var label: UILabel!

    /// UIの初期化
    func initUI() {
        containerView.backgroundColor = Asset.backgroundColorWhite.color
        label.textColor = Asset.textColorDisabled.color
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    /// セルの横幅を返す
    static func calcWidth(text: String) -> CGFloat {
        var width: CGFloat = 20
        let tmpLabel = UILabel()
        tmpLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tmpLabel.text = text
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
        width += tmpLabel.sizeThatFits(maxSize).width
        return width
    }

    /// データのセット
    /// - Parameters:
    ///   - text: ラベル文字
    ///   - isActive: 活性状態
    func setDetails(text: String, isActive: Bool) {
        initUI()
        label.text = text
        if isActive {
            label.textColor = Asset.primaryColor.color
            underView.backgroundColor = Asset.primaryColor.color
        } else {
            label.textColor = Asset.textColorDisabled.color
            underView.backgroundColor = Asset.backgroundColorWhite.color
        }
    }
}

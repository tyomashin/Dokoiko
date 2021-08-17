//
//  MainContentCell.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/03.
//

import UIKit

/// メイン画面のセル
class MainContentCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    /// 初期化処理
    private func initCustom() {
        backgroundColor = Asset.backgroundColorPurple.color
        containerView.backgroundColor = Asset.backgroundColorPurple.color
        leftView.backgroundColor = Asset.backgroundColorWhite.color
        leftView.layer.cornerRadius = 5
        leftLabel.textColor = Asset.textThinColor.color
        leftLabel.font = .boldSystemFont(ofSize: 18)
        borderView.backgroundColor = Asset.strokeColor.color
        borderView.isHidden = true
        mainLabel.textColor = Asset.textColor.color
        subLabel.textColor = Asset.textThinColor.color
        mainLabel.font = .systemFont(ofSize: 24)
        subLabel.font = .systemFont(ofSize: 12)
        selectionStyle = .none
    }

    /// セルの内容をセットする
    func setDetails(topText: String, firstText: String, subText: String) {
        leftLabel.text = topText
        mainLabel.text = firstText
        subLabel.text = subText

        initCustom()
    }

    /// セルのハイライト状態を変更する
    /// - Parameter hilightState: ハイライトかどうか
    func setCellHighlight(hilightState: Bool) {
        if hilightState {
            alpha = 0.6
        } else {
            alpha = 1
        }
    }
}

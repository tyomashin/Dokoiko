//
//  LabelView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/22.
//

import UIKit

/// ラベルView
class LabelView: UIView {
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var label: UILabel!

    /// コードからの初期化時に呼ばれる
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustom()
    }

    /// ストーリーボードからの初期化時に呼ばれる
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustom()
    }

    /// 画面初期化時に呼ばれる
    private func initCustom() {
        Bundle(for: LabelView.self).loadNibNamed("LabelView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.backgroundColor = Asset.backgroundColor.color
        label.textColor = Asset.textColorWhite.color
        label.font = .boldSystemFont(ofSize: 10)

        baseView.layer.cornerRadius = 5
    }

    /// データをセット
    /// - Parameters:
    ///   - text: 文言
    ///   - textColor: 文字色
    ///   - viewColor: 背景色
    /// - Returns: Viewのサイズ
    @discardableResult
    func setDetails(
        text: String,
        textColor: UIColor = Asset.textColorWhite.color,
        viewColor: UIColor = Asset.backgroundColor.color
    ) -> CGFloat {
        label.text = text
        label.textColor = textColor
        baseView.backgroundColor = viewColor

        // 横幅を計算
        var width: CGFloat = 0
        // マージン
        width += 5 * 2
        let tmpLabel = UILabel()
        tmpLabel.font = label.font
        tmpLabel.text = text
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
        width += tmpLabel.sizeThatFits(maxSize).width
        return width
    }
}

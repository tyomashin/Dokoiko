//
//  LinkLabelButton.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/14.
//

import UIKit

/// リンクラベルボタン
class LinkLabelButton: UIView {
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var coverButton: UIButton!
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
        Bundle(for: LinkLabelButton.self).loadNibNamed("LinkLabelButton", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.layer.cornerRadius = 10
        baseView.backgroundColor = Asset.backgroundColorClearPrimary.color

        label.font = .systemFont(ofSize: 14)
        label.textColor = Asset.primaryColor.color
    }

    /// 文言を設定して、高さを返す
    func setDetails(text: String?, baseWidth: CGFloat) -> CGFloat {
        label.text = text
        var targetHeight: CGFloat = 30
        let maxSize = CGSize(width: baseWidth - 40, height: CGFloat.greatestFiniteMagnitude)
        targetHeight += label.sizeThatFits(maxSize).height
        return targetHeight
    }
}

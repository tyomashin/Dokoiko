//
//  LinkButton.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/13.
//

import UIKit

/// リンクボタン
class LinkButton: UIView {
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var coverButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
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
        Bundle(for: LinkButton.self).loadNibNamed("LinkButton", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.layer.cornerRadius = 5
        baseView.backgroundColor = Asset.backgroundColorClearPrimary.color

        label.textColor = Asset.primaryColor.color
        label.font = .boldSystemFont(ofSize: 12)

        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Asset.primaryColor.color
    }

    /// 見た目を設定する
    func setDetails(iconImage: UIImage, text: String) {
        imageView.image = iconImage.withRenderingMode(.alwaysTemplate)
        label.text = text
    }
}

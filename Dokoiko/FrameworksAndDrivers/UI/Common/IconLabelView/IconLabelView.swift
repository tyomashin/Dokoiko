//
//  IconLabelView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/22.
//

import UIKit

/// アイコンとラベルのView
class IconLabelView: UIView {
    @IBOutlet var baseView: UIView!
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
        Bundle(for: IconLabelView.self).loadNibNamed("IconLabelView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        // baseView.backgroundColor = Asset.backgroundColor.color
        label.textColor = Asset.textColor.color
        label.font = .boldSystemFont(ofSize: 12)
    }

    /// データのセット
    func setDetails(title: String?, icon: UIImage?) {
        label.text = title
        imageView.image = icon?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
    }
}

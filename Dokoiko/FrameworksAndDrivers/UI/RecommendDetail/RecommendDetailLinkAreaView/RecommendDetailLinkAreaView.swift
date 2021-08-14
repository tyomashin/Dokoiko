//
//  RecommendDetailLinkAreaView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/13.
//

import UIKit

/// 推薦詳細画面のリンク表示領域
class RecommendDetailLinkAreaView: UIView {
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var leftLinkButton: LinkButton!
    @IBOutlet weak var rightLinkButton: LinkButton!

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
        Bundle(for: RecommendDetailLinkAreaView.self).loadNibNamed("RecommendDetailLinkAreaView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        imageView.image = UIImage.colorImage(withColor: Asset.backgroundColorWhite.color)
        imageView.contentMode = .scaleToFill

        leftLinkButton.layer.cornerRadius = 5
        leftLinkButton.backgroundColor = Asset.backgroundColorClearPrimary.color
        rightLinkButton.layer.cornerRadius = 5
        rightLinkButton.backgroundColor = Asset.backgroundColorClearPrimary.color

        leftLinkButton.setDetails(iconImage: Asset.compass.image, text: L10n.SpotDetail.Link.web)
        rightLinkButton.setDetails(iconImage: Asset.mapIcon.image, text: L10n.SpotDetail.Link.route)
    }
}

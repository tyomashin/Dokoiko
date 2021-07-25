//
//  RecommendPageCell.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/21.
//

import UIKit

/// 推薦リストセル
class RecommendPageCell: UITableViewCell {
    private var spotEntity: RecommendSpotEntity?

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var couponLabelView: LabelView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceIconLabelView: IconLabelView!

    /// 初期化処理
    private func initCustom() {
        backgroundColor = Asset.backgroundColor.color
        contentView.backgroundColor = Asset.backgroundColor.color
        distanceIconLabelView.backgroundColor = Asset.backgroundColorWhite.color
        topView.backgroundColor = Asset.primaryColor.color
        topView.addBackgroundBlur()

        nameLabel.textColor = Asset.textColor.color
        nameLabel.font = .boldSystemFont(ofSize: 16)

        topImageView.contentMode = .scaleAspectFit

        detailView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 10)
    }

    /// セルの内容を初期化する
    private func initCellDetails() {
        nameLabel.text = nil
        topImageView.image = nil
        categoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    /// セルの内容をセットする
    func setDetails(entity: RecommendSpotEntity, category: SpotCategory) {
        initCustom()
        initCellDetails()

        spotEntity = entity

        // デフォルト画像のセット
        setDefaultImage(category: category)

        nameLabel.text = entity.name
        // クーポンがある場合
        if entity.coupons?.isEmpty == false {
            // クーポンラベルを表示
            couponLabelView.isHidden = false
            couponLabelView.setDetails(text: L10n.Coupon.title, textColor: Asset.textThinColor.color, viewColor: Asset.accentColor.color)
        } else {
            couponLabelView.isHidden = true
        }

        // カテゴリラベルのセット
        setCategoryLabel(entity: entity)

        // 距離アイコンViewのセット
        var distanceStr = "--"
        if let distance = entity.distanceKM {
            distanceStr = String(format: "%.1f km", distance)
        }
        distanceIconLabelView.setDetails(title: distanceStr, icon: Asset.directionsCarFilledBlack.image)
    }

    /// デフォルト画像をセットする
    private func setDefaultImage(category: SpotCategory) {
        // カテゴリごとのデフォルト画像をセット
        switch category {
        case .restaurant:
            topImageView.image = Asset.restaurantDefaultImage.image

        case .shopping:
            topImageView.image = Asset.shoppingDefaultImage.image

        case .leisure:
            topImageView.image = Asset.leisureDefaultImage.image

        case .lifestyle:
            topImageView.image = Asset.lifestyleDefaultImage.image
        }
    }

    /// カテゴリラベルをセット
    private func setCategoryLabel(entity: RecommendSpotEntity) {
        guard let categoryList = entity.genre else {
            return
        }

        // 表示できる横幅計算用
        var totalWidth: CGFloat = 0
        let maxWidth: CGFloat = 250
        let spacing: CGFloat = categoryStackView.spacing

        for category in categoryList {
            let categoryView = LabelView(frame: .zero)
            let tmpWidth = categoryView.setDetails(text: category, textColor: Asset.textColorWhite.color, viewColor: Asset.subPinkColor.color)
            totalWidth += tmpWidth + spacing
            if totalWidth >= maxWidth {
                break
            }
            categoryStackView.addArrangedSubview(categoryView)
            categoryView.translatesAutoresizingMaskIntoConstraints = false
            categoryView.widthAnchor.constraint(equalToConstant: tmpWidth).isActive = true
        }
    }
}

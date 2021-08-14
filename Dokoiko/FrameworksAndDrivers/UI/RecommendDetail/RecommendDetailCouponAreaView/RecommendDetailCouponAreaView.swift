//
//  RecommendDetailCouponAreaView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/14.
//

import RxCocoa
import RxSwift
import UIKit

/// 推薦詳細画面のクーポンエリアView
class RecommendDetailCouponAreaView: UIView {
    // 選択されたアイテムの通知用
    fileprivate let selectedCouponRelay = BehaviorRelay<RecommendSpotCoupon?>(value: nil)
    private let disposeBag = DisposeBag()

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackView: UIStackView!

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
        Bundle(for: RecommendDetailCouponAreaView.self).loadNibNamed("RecommendDetailCouponAreaView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.backgroundColor = Asset.backgroundColorWhite.color

        label.text = L10n.Coupon.title
        label.textColor = Asset.textColor.color
        label.font = .boldSystemFont(ofSize: 18)
    }

    /// クーポン情報を表示して、高さを変える
    func setDetails(couponList: [RecommendSpotCoupon?]) -> CGFloat {
        // 表示する情報がない場合
        if couponList.isEmpty {
            return 0
        }

        var targetHeight: CGFloat = label.frame.height + 10
        let spacing: CGFloat = stackView.spacing

        for coupon in couponList {
            let linkView = LinkLabelButton(frame: .zero)
            let couponText: String
            if let name = coupon?.name {
                couponText = name
            } else if let name = coupon?.url {
                couponText = name
            } else {
                couponText = L10n.Coupon.title
            }

            stackView.layoutIfNeeded()
            let tmpHeight = linkView.setDetails(text: couponText, baseWidth: stackView.frame.width)
            targetHeight += tmpHeight + spacing

            stackView.addArrangedSubview(linkView)
            linkView.translatesAutoresizingMaskIntoConstraints = false
            linkView.heightAnchor.constraint(equalToConstant: tmpHeight).isActive = true

            linkView.coverButton.rx.tap.subscribe(onNext: { [weak self] in
                self?.selectedCouponRelay.accept(coupon)
            })
            .disposed(by: disposeBag)
        }

        return targetHeight
    }
}

extension Reactive where Base: RecommendDetailCouponAreaView {
    /// 選択されたクーポンのイベント
    var selectedCoupon: Driver<RecommendSpotCoupon> {
        base.selectedCouponRelay.asDriver().compactMap { $0 }
    }
}

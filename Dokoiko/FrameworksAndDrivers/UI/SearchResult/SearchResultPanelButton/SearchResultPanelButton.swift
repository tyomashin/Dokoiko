//
//  SearchResultPanelButton.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/03.
//

import RxCocoa
import RxSwift
import UIKit

/// 検索結果画面のパネルボタンView
class SearchResultPanelButton: UIView {
    weak var backgroundView: UIView?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var coverButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

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
        let bundle = Bundle(for: SearchResultPanelButton.self)
        guard let view = bundle.loadNibNamed("SearchResultPanelButton", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        backgroundView = view
        addSubview(view)

        // UI初期化
        initUI(view: view)
    }

    /// UI初期化
    private func initUI(view: UIView) {
        view.backgroundColor = Asset.backgroundColorWhite.color
        view.layer.cornerRadius = 10

        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Asset.iconBlackColor.color

        // タップ時の見た目制御
        coverButton
            .rx.controlEvent([.touchUpOutside, .touchUpInside])
            .subscribe(onNext: { [weak self] in
                self?.backgroundView?.alpha = 1
            })
            .disposed(by: disposeBag)

        coverButton
            .rx.controlEvent([.touchDown])
            .subscribe(onNext: { [weak self] in
                self?.backgroundView?.alpha = 0.6
            })
            .disposed(by: disposeBag)
    }

    /// 画面に表示する情報を受け取る
    func setViewDetails(title: String, iconImage: UIImage) {
        titleLabel.text = title
        iconImageView.image = iconImage.withRenderingMode(.alwaysTemplate)
    }
}

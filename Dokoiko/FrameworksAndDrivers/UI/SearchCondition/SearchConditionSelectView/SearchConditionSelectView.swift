//
//  SearchConditionSelectView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/17.
//

import RxCocoa
import RxSwift
import UIKit

/// 検索条件画面の検索条件選択ボタンview
class SearchConditionSelectView: UIView {
    private let BUTTON_HEIGHT: CGFloat = 45
    // 高さ通知用
    fileprivate let myHeightRelay = BehaviorRelay<CGFloat>(value: 150)
    // 選択されたアイテムの通知用
    fileprivate let selectedItemRelay = BehaviorRelay<Int?>(value: nil)

    private var searchConditionTypeList = [SearchConditionData]()
    private var buttonList = [UIButton]()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var stackViewBottonSpacingConstraint: NSLayoutConstraint!

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
        let bundle = Bundle(for: SearchConditionSelectView.self)
        guard let view = bundle.loadNibNamed("SearchConditionSelectView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)

        view.backgroundColor = Asset.backgroundColor.color
        emptyLabel.textColor = Asset.textThinColor.color
        emptyLabel.text = L10n.SearchCondition.empty
        emptyLabel.font = .systemFont(ofSize: 14)
    }

    /// 単一選択可能なボタンリストを初期化する
    private func initButtonList() {
        for targetView in stackView.arrangedSubviews {
            targetView.removeFromSuperview()
        }
        buttonList = []

        for entity in searchConditionTypeList {
            let button = UIButton(type: .custom)
            button.tag = entity.tag
            button.setTitle(entity.title, for: .normal)
            button.setBackgroundImage(UIImage.colorImage(withColor: Asset.primaryColor.color), for: .selected)
            // memo: selected状態でタップした時にチカチカするのは、以下指定の「normal」状態の色が適用されるため。
            // memo: これを避けるにはカスタムボタンを作成する必要がある（押された時の色、離された時の色を自分で指定できるようにする）
            button.setBackgroundImage(UIImage.colorImage(withColor: Asset.backgroundColorPurple.color), for: .normal)
            button.isHighlighted = false
            button.adjustsImageWhenHighlighted = false
            button.adjustsImageWhenDisabled = false
            button.setTitleColor(Asset.textColorWhite.color, for: .selected)
            button.setTitleColor(Asset.textThinColor.color, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            stackView.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 45).isActive = true
            buttonList.append(button)

            button.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.tapConditionButton(targetTag: button.tag)
            })
            .disposed(by: disposeBag)
        }
        // 高さを更新
        calcMyHeight()
    }

    /// 検索条件種別リストを格納する
    fileprivate func setConditionList(searchConditionTypeList: [SearchConditionData]) {
        self.searchConditionTypeList = searchConditionTypeList
        /// 単一選択可能なボタンリストを初期化する
        initButtonList()
    }

    /// 検索条件切り替えボタンがタップされた時の処理
    /// - Parameter targetTag: ボタンのタグ
    private func tapConditionButton(targetTag: Int) {
        // emptyラベルは非表示にする
        emptyLabel.isHidden = true
        var isChanged = false
        // タップされたボタンのみ選択状態にする
        for button in buttonList {
            if button.tag == targetTag {
                if !button.isSelected {
                    isChanged = true
                }
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        // 選択状態が変わった場合
        if isChanged {
            // イベントを通知
            selectedItemRelay.accept(targetTag)
        }
    }

    /// 自身の高さを計算する
    private func calcMyHeight() {
        var totalHeight: CGFloat = 0
        // stackViewの高さ
        totalHeight += CGFloat(buttonList.count) * BUTTON_HEIGHT
        if buttonList.count >= 2 {
            totalHeight += stackView.spacing * CGFloat(buttonList.count - 1)
        }
        totalHeight += stackViewBottonSpacingConstraint.constant
        // エンプティラベルの高さ
        totalHeight += emptyLabel.frame.height
        myHeightRelay.accept(totalHeight)
    }
}

extension Reactive where Base: SearchConditionSelectView {
    /// 自身の高さ
    var myHeight: Driver<CGFloat> {
        base.myHeightRelay.asDriver()
    }

    var selectedItem: Driver<Int> {
        base.selectedItemRelay.asDriver().compactMap { $0 }
    }

    /// 検索条件種別リスト
    var conditionTypeList: Binder<[SearchConditionData]> {
        Binder(base) { view, list in
            view.setConditionList(searchConditionTypeList: list)
        }
    }
}

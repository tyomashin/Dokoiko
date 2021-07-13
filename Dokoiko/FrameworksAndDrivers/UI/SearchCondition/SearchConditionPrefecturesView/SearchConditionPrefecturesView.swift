//
//  SearchConditionPrefecturesView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/21.
//

import RxCocoa
import RxSwift
import UIKit

/// 「都道府県から検索」の場合の検索条件画面
class SearchConditionPrefecturesView: UIView {
    private let disposeBag = DisposeBag()
    // エリアを選択するview
    private var regionBlockView: SearchConditionPrefectureRowView?
    // 都道府県を選択するview
    private var prefectureView: SearchConditionPrefectureRowView?
    // 選択されたインデックスの情報
    fileprivate let areaSelectedIndexRelay = BehaviorRelay<Int?>(value: nil)
    fileprivate let prefectureSelectedIndexRelay = BehaviorRelay<Int?>(value: nil)

    @IBOutlet var baseView: UIView!
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
        Bundle(for: SearchConditionPrefecturesView.self).loadNibNamed("SearchConditionPrefecturesView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        baseView.backgroundColor = Asset.backgroundColor.color

        initSearchConditionViews()
    }

    /// StackViewに表示する検索条件viewを初期化
    private func initSearchConditionViews() {
        let regionBlockView = SearchConditionPrefectureRowView(frame: .zero)
        stackView.addArrangedSubview(regionBlockView)
        regionBlockView.translatesAutoresizingMaskIntoConstraints = false
        regionBlockView.topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // アニメーション設定
        animateSettingSearchConditionView(rowView: regionBlockView)
        regionBlockView.pickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                self?.areaSelectedIndexRelay.accept(row)
            })
            .disposed(by: disposeBag)
        self.regionBlockView = regionBlockView

        let prefectureView = SearchConditionPrefectureRowView(frame: .zero)
        stackView.addArrangedSubview(prefectureView)
        prefectureView.translatesAutoresizingMaskIntoConstraints = false
        prefectureView.topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        animateSettingSearchConditionView(rowView: prefectureView)
        prefectureView.pickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                self?.prefectureSelectedIndexRelay.accept(row)
            })
            .disposed(by: disposeBag)

        self.prefectureView = prefectureView
    }

    /// 検索条件Viewをタップした時のアニメーション処理
    private func animateSettingSearchConditionView(rowView: SearchConditionPrefectureRowView) {
        rowView.converButton.rx.tap.subscribe(onNext: {
            // ピッカーを表示するかどうか
            let isPickerShow = rowView.pickerViewHeightConstraint.constant == 0
            // ピッカーを非表示にする場合はアニメーション前に透明にしておく
            let pickerAlpha: CGFloat = isPickerShow ? 1 : 0
            rowView.pickerView.alpha = pickerAlpha
            if isPickerShow {
                rowView.changePickerConstraints(heightConstant: rowView.PICKER_HEIGHT)
            } else {
                rowView.changePickerConstraints(heightConstant: 0)
            }
            rowView.changeImageViewAngle(isPickerShow: isPickerShow, animated: true)

            // StackView 内のカスタムviewをアニメーション
            // 参考：https://stackoverflow.com/questions/33700522/stackview-animation-collapse-of-arranged-subviews
            UIView.animate(withDuration: rowView.ANIMATION_DURATION, animations: { [weak self] in
                self?.stackView.layoutIfNeeded()
                self?.stackView.superview?.layoutIfNeeded()
            }, completion: { _ in
                rowView.pickerView.alpha = 1
            })
        })
        .disposed(by: disposeBag)
    }

    /// 検索条件オブジェクトを受け取ってViewを初期化
    fileprivate func setSearchCondition(searchCondition: SearchConditionPrefectures) {
        guard let regionBlockView = regionBlockView, let prefectureView = prefectureView else { return }
        let regionList = searchCondition.regionBlockList.map(\.name)
        regionBlockView.setDetails(
            title: L10n.SearchCondition.Area.title,
            dataList: regionList,
            selectedIndex: searchCondition.selectedRegionBlockIndex
        )
        let prefectureList = searchCondition.prefecturesList.map(\.name)
        prefectureView.setDetails(
            title: L10n.SearchCondition.Prefecture.title,
            dataList: prefectureList,
            selectedIndex: searchCondition.selectedPrefectureIndex
        )
    }
}

extension Reactive where Base: SearchConditionPrefecturesView {
    /// 検索条件オブジェクト
    var searchCondication: Binder<SearchConditionPrefectures> {
        Binder(base) { view, condition in
            view.setSearchCondition(searchCondition: condition)
        }
    }

    /// 選択されたエリアのインデックス
    var areaSelectedIndex: Driver<Int> {
        base.areaSelectedIndexRelay.asDriver().compactMap { $0 }
    }

    /// 選択された都道府県のインデックス
    var prefectureSelectedIndex: Driver<Int> {
        base.prefectureSelectedIndexRelay.asDriver().compactMap { $0 }
    }
}

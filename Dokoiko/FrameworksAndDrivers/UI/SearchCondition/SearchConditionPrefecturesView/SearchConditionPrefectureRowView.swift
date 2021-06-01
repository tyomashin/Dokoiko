//
//  SearchConditionPrefectureRowView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/22.
//

import RxCocoa
import RxSwift
import UIKit

/// 「都道府県から検索」の場合の検索条件画面で表示する行のview
class SearchConditionPrefectureRowView: UIView {
    internal let PICKER_HEIGHT: CGFloat = 150
    internal let ANIMATION_DURATION: TimeInterval = 0.3
    private var dataList = [String]()
    private var selectedIndex = 0
    private let disposeBag = DisposeBag()

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var converButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerViewHeightConstraint: NSLayoutConstraint!

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
        let bundle = Bundle(for: SearchConditionPrefectureRowView.self)
        guard let view = bundle.loadNibNamed("SearchConditionPrefectureRowView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)

        view.backgroundColor = Asset.backgroundColor.color
        topView.backgroundColor = Asset.backgroundColor.color
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = Asset.textThinColor.color
        valueLabel.font = .systemFont(ofSize: 18)
        valueLabel.textColor = Asset.primaryDarkColor.color
        imageView.image = Asset.baselineKeyboardArrowDown.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Asset.textThinColor.color

        changePickerConstraints(heightConstant: 0)
    }

    /// 画面表示するデータを更新する
    internal func setDetails(title: String, dataList: [String], selectedIndex: Int) {
        titleLabel.text = title
        valueLabel.text = dataList[selectedIndex]
        self.dataList = dataList
        self.selectedIndex = selectedIndex
        // 参考：https://stackoverflow.com/questions/42305155/rxswift-and-uipickerview
        Observable.just(dataList)
            .bind(to: pickerView.rx.itemTitles) { _, element in
                element
            }
            .disposed(by: disposeBag)

        pickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                guard let self = self else { return }
                self.valueLabel.text = self.dataList[row]
            })
            .disposed(by: disposeBag)

        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
    }

    /// ピッカーの高さ制約を変更する
    internal func changePickerConstraints(heightConstant: CGFloat) {
        pickerViewHeightConstraint.constant = heightConstant
    }

    /// 矢印の画像の向きを変更する
    internal func changeImageViewAngle(isPickerShow: Bool, animated: Bool) {
        let imageViewAngle: CGFloat
        if isPickerShow {
            imageViewAngle = 180 * CGFloat.pi / 180
        } else {
            imageViewAngle = 0 * CGFloat.pi / 180
        }
        if animated {
            UIView.animate(withDuration: ANIMATION_DURATION) { [weak self] in
                let transRotate = CGAffineTransform(rotationAngle: CGFloat(imageViewAngle))
                self?.imageView.transform = transRotate
            }
        } else {
            let transRotate = CGAffineTransform(rotationAngle: CGFloat(imageViewAngle))
            imageView.transform = transRotate
        }
    }
}

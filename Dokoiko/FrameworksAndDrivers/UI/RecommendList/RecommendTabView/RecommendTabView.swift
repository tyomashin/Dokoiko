//
//  RecommendTabView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/16.
//

import RxCocoa
import RxSwift
import UIKit

/// 推薦画面のタブView
class RecommendTabView: UIView {
    let selectedIndexRelay = BehaviorRelay<Int>(value: 0)
    var selectedIndex: Int = 0
    var dataList = [String]()

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

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
        Bundle(for: RecommendTabView.self).loadNibNamed("RecommendTabView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        collectionView.register(UINib(nibName: "RecommendTabViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendTabViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        // UI初期化
        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.backgroundColor = Asset.backgroundColorWhite.color
    }

    /// データの更新
    func updateContents() {
        collectionView.reloadData()
    }
}

extension RecommendTabView: UICollectionViewDelegateFlowLayout {
    /// セルのサイズを返す
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = collectionView.frame.height
        let width = RecommendTabViewCell.calcWidth(text: dataList[indexPath.row])
        return CGSize(width: width, height: height)
    }

    /// 余白を設定する
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        var totalWidth: CGFloat = 0
        for text in dataList {
            totalWidth += RecommendTabViewCell.calcWidth(text: text)
        }
        if collectionView.frame.width > totalWidth {
            let diff = collectionView.frame.width - totalWidth
            return UIEdgeInsets(top: 0, left: diff / 2, bottom: 0, right: diff / 2)
        } else {
            return .zero
        }
    }
}

extension RecommendTabView: UICollectionViewDelegate {
    /// タブが選択された時の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedIndexRelay.accept(indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}

extension RecommendTabView: UICollectionViewDataSource {
    /// セル数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }

    /// セルを生成して返す
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendTabViewCell", for: indexPath)

        if let cell = cell as? RecommendTabViewCell {
            cell.initUI()
            if indexPath.row == selectedIndex {
                cell.setDetails(text: dataList[indexPath.row], isActive: true)
            } else {
                cell.setDetails(text: dataList[indexPath.row], isActive: false)
            }
        }

        return cell
    }
}

extension Reactive where Base: RecommendTabView {
    // タブに表示するデータ情報
    var tabDatas: Binder<(categoryList: [String], selectedIndex: Int)> {
        Binder(base) { view, data in
            view.selectedIndex = data.selectedIndex
            view.dataList = data.categoryList
            view.updateContents()
        }
    }

    // 選択されたタブのインデックス
    var selectedTabIndex: Driver<Int> {
        base.selectedIndexRelay.asDriver()
    }
}

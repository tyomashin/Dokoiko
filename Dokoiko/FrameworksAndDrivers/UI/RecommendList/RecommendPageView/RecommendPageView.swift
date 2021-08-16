//
//  RecommendPageView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/21.
//

import RxCocoa
import RxSwift
import UIKit

/// 推薦リストの各ページ画面
class RecommendPageView: UIView {
    typealias ScrollInfo = (tag: Int, topOffset: CGFloat, currentTopOffset: CGFloat)

    /// データ読み込み状態
    enum ListLoadingState {
        // 読み込み中
        case loading
        // 読み込み完了
        case complete(category: SpotCategory, spotList: [RecommendSpotEntity])
    }

    private let CELL_HEIGHT: CGFloat = 280
    /// TableView上の余白
    var tableViewTopInsets: CGFloat = 0
    /// 直近のTableView移動量
    private var currentTopOffset: CGFloat?
    /// データ読み込み状態
    var listLoadingState = ListLoadingState.loading
    /// データリスト
    private var spotEntityList = [RecommendSpotEntity]()
    /// カテゴリ
    private var spotCategory = SpotCategory.leisure
    /// スクロールイベント
    let scrollInfoRelay = BehaviorRelay<ScrollInfo?>(value: nil)
    /// セルの選択イベント
    let selectedCellRelay = BehaviorRelay<RecommendListVCProtocol.SpotInfo?>(value: nil)
    /// リスト初期化済みフラグ
    private var isListInitFlag = false
    /// 一時保存中のTableViewのOFFSET
    private var tmpContentOffset: CGPoint?

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!

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
        Bundle(for: RecommendPageView.self).loadNibNamed("RecommendPageView", owner: self, options: nil)
        baseView.frame = bounds
        addSubview(baseView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RecommendPageCell", bundle: nil), forCellReuseIdentifier: "RecommendPageCell")

        // UI初期化
        initUI()
    }

    /// UI初期化
    private func initUI() {
        baseView.backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color

        tableView.separatorStyle = .none
    }

    /// 画面情報をセット
    func setTableViewInsets(topInsets: CGFloat) {
        tableViewTopInsets = topInsets
        currentTopOffset = -topInsets
        tableView.contentInset = UIEdgeInsets(top: tableViewTopInsets, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }

    /// リストのローディング状態をセットする
    func setListLoadingState(state: ListLoadingState) {
        listLoadingState = state
        switch state {
        // ローディング状態
        case .loading:
            // ローディング中の表示にする
            tableView.isHidden = true
            loadingImageView.isHidden = false
            emptyLabel.isHidden = true
            animateLoadingImage()

        // 読み込み完了状態
        case let .complete(category: category, spotList: spotList):
            isListInitFlag = true
            // リストが空の場合
            if spotList.isEmpty {
                // エンプティステート
                loadingImageView.isHidden = true
                loadingImageView.animationImages = nil
                emptyLabel.isHidden = false
                emptyLabel.font = .boldSystemFont(ofSize: 20)
                emptyLabel.textColor = Asset.textColor.color
                emptyLabel.text = L10n.SpotList.empty
            }
            // 表示するスポットがある場合
            else {
                // リストを表示する
                tableView.isHidden = false
                loadingImageView.isHidden = true
                loadingImageView.animationImages = nil
                emptyLabel.isHidden = true
                // OFFSETが渡されている場合は反映
                if let offset = tmpContentOffset {
                    tableView.delegate = nil
                    tableView.setContentOffset(offset, animated: false)
                    currentTopOffset = offset.y
                    tmpContentOffset = nil
                    tableView.delegate = self
                }
                // データをリロードする
                spotCategory = category
                spotEntityList = spotList
                tableView.reloadData()
            }
        }
    }

    /// ローディング表示
    private func animateLoadingImage() {
        // ローディング素材：https://icons8.com/preloaders/
        let images = UIImage.gifImages(resourceName: "loading")
        loadingImageView.animationImages = images
        // 1回のアニメーション時間（秒）
        loadingImageView.animationDuration = 1
        // リピートする
        loadingImageView.animationRepeatCount = 0
        loadingImageView.startAnimating()
    }

    /// TableViewのオフセットを調整する
    func setContentOffset(newOffset: CGPoint) {
        // すでにスポットを表示している場合はここでTableViewのオフセットを反映
        if isListInitFlag {
            // memo: scrollViewDidScrollがトリガーされないようにする
            // 参考：https://codehero.jp/ios/9418311/setting-contentoffset-programmatically-triggers-scrollviewdidscroll
            tableView.delegate = nil
            tableView.setContentOffset(newOffset, animated: false)
            currentTopOffset = newOffset.y
            tableView.delegate = self
        }
        // まだスポットを表示していない場合、一時的にオフセットを保持
        else {
            tmpContentOffset = newOffset
        }
    }
}

extension RecommendPageView: UITableViewDelegate {
    /// スクロールされた時に呼ばれる
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 新しいオフセット
        let topOffset = scrollView.contentOffset.y
        if let currentTopOffset = currentTopOffset {
            // イベント発行
            scrollInfoRelay.accept((tag, topOffset, currentTopOffset))
            // 直近のオフセットを保存
            self.currentTopOffset = topOffset
        }
    }
}

extension RecommendPageView: UITableViewDataSource {
    /// セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CELL_HEIGHT
    }

    /// 要素数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        spotEntityList.count
    }

    /// セルを生成して返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendPageCell") as? RecommendPageCell else {
            return UITableViewCell()
        }

        let entity = spotEntityList[indexPath.row]
        cell.setDetails(entity: entity, category: spotCategory)
        // 画像URLがあれば
        if let urlStr = entity.imageUrl {
            UIImage.getImageWithKingfisher(urlStr: urlStr) { image in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }

        return cell
    }

    /// セルが選択された時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spot = spotEntityList[indexPath.row]
        selectedCellRelay.accept((spot, spotCategory))
    }
}

extension Reactive where Base: RecommendPageView {
    /// リスト上の余白
    var topInsets: Binder<CGFloat> {
        Binder(base) { view, insets in
            view.setTableViewInsets(topInsets: insets)
        }
    }

    /// データ取得状態
    var listLoadingState: Binder<Base.ListLoadingState> {
        Binder(base) { _, state in
            base.setListLoadingState(state: state)
        }
    }

    /// リストスクロール時の情報
    var scrollInfo: Driver<Base.ScrollInfo> {
        base.scrollInfoRelay.asDriver().compactMap { $0 }
    }

    /// セルが選択された時のイベント
    var selectedSpot: Driver<RecommendListVCProtocol.SpotInfo> {
        base.selectedCellRelay.asDriver().compactMap { $0 }
    }
}

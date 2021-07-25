//
//  RecommendListViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/14.
//

import RxCocoa
import RxSwift
import UIKit

/// 推薦リスト画面が準拠するプロトコル
protocol RecommendListVCProtocol: AnyObject {
    /// 閉じるボタンがタップされた時のイベント
    var tapCloseButton: Driver<Void> { get }
    /// 現在のページ
    var currentPage: Driver<Int> { get }
}

/// 推薦リスト画面
class RecommendListViewController: UIViewController {
    // スポットリストViewと紐づくカテゴリのデータ型
    typealias SpotPageViewWithCategory = (spotPageView: RecommendPageView, category: SpotCategory)

    private var viewModel: RecommendListViewModelProtocol?
    private let disposeBag = DisposeBag()
    // スポット表示用のViewリスト
    private var spotViewList = [SpotPageViewWithCategory]()
    // 現在のページ
    private let currentPageRelay = BehaviorRelay<Int?>(value: nil)
    // 閉じるボタンの表示状態
    private var isShowingFloatinButton = false

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var tabView: RecommendTabView!
    @IBOutlet weak var spotTitleLabel: UILabel!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var spotStackView: UIStackView!
    @IBOutlet weak var floatCloseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        view.backgroundColor = Asset.backgroundColor.color
        headerView.backgroundColor = Asset.backgroundColorWhite.color
        spotTitleLabel.textColor = Asset.textColor.color
        spotTitleLabel.font = .boldSystemFont(ofSize: 24)
        spotTitleLabel.text = L10n.SpotList.title

        closeImageView.image = Asset.outlineCloseBlack.image
        closeImageView.contentMode = .scaleAspectFit
        closeImageView.tintColor = Asset.textColor.color

        floatCloseButton.isHidden = true
        let closeImage = Asset.outlineCloseBlack.image.withRenderingMode(.alwaysTemplate)
        floatCloseButton.setImage(closeImage, for: .normal)
        floatCloseButton.tintColor = Asset.textColorWhite.color
        floatCloseButton.backgroundColor = Asset.subPinkColor.color
        floatCloseButton.imageView?.contentMode = .scaleAspectFit
        floatCloseButton.layer.cornerRadius = floatCloseButton.frame.width / 2
        floatCloseButton.dropShadow(scale: true, color: Asset.primaryDarkColor.color)
        floatCloseButton.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)

        scrollView.delegate = self

        // タブバーの下辺を角丸にする
        tabView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }

        bindViews()
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: 推薦リスト画面のViewModel
    internal func inject(viewModel: RecommendListViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: 推薦リスト画面のViewModel
    private func bindViewModel(viewModel: RecommendListViewModelProtocol) {
        viewModel
            .categoryInfo
            .drive(tabView.rx.tabDatas)
            .disposed(by: disposeBag)

        viewModel
            .categoryList
            .drive(onNext: { [weak self] categoryList in
                self?.setSpotVCs(categoryList: categoryList)
            })
            .disposed(by: disposeBag)

        viewModel
            .spotEntityData
            .drive(onNext: { [weak self] spotEntityData in
                self?.notifySpotList(spotDataList: spotEntityData)
            })
            .disposed(by: disposeBag)
    }

    /// Viewとバインディング
    private func bindViews() {
        // タブが選択された時のイベントを購読
        tabView.rx.selectedTabIndex
            .drive(onNext: { [weak self] index in
                self?.changePage(index: index)
                // ページング処理
                self?.pagingTo(index: index)
            })
            .disposed(by: disposeBag)
    }

    /// Spot表示用のView を初期化する
    private func setSpotVCs(categoryList: [SpotCategory]) {
        if !spotViewList.isEmpty {
            return
        }
        for pageIndex in 0 ..< categoryList.count {
            let category = categoryList[pageIndex]
            let pageView = RecommendPageView(frame: .zero)
            let tableViewTopInset = headerView.frame.height + tabView.frame.height
            pageView.setTableViewInsets(topInsets: tableViewTopInset)
            pageView.setListLoadingState(state: .loading)
            spotStackView.addArrangedSubview(pageView)
            pageView.translatesAutoresizingMaskIntoConstraints = false
            pageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            spotViewList.append((pageView, category))
            pageView.tag = pageIndex

            pageView.rx.scrollInfo
                .drive(onNext: { [weak self] scrollInfo in
                    if self?.currentPageRelay.value == scrollInfo.tag {
                        self?.changeScrollInfo(scrollInfo: scrollInfo, topInset: tableViewTopInset)
                    }
                })
                .disposed(by: disposeBag)
        }

        // 最初のページを選択状態にする
        changePage(index: 0)
    }

    /// ページが変わったことをViewModelに通知
    private func changePage(index: Int) {
        currentPageRelay.accept(index)
    }

    /// ページ移動処理
    private func pagingTo(index: Int) {
        // スクロールViewを移動
        let pointX: CGFloat = scrollView.bounds.size.width * CGFloat(index)
        scrollView.setContentOffset(.init(x: pointX, y: 0), animated: true)
    }

    /// スポットリストが更新された時の処理
    /// - Parameter spotDataList: ViewModelから受け取ったスポット情報
    private func notifySpotList(spotDataList: [RecommendListViewModelProtocol.SpotEntityData]) {
        for spotData in spotDataList {
            // 対象カテゴリのページViewを取得
            let pageView = spotViewList.first(where: { $0.category == spotData.category })?.spotPageView
            // 現在読み込み中のページViewに対してスポットリストを通知
            if case .loading = pageView?.listLoadingState {
                pageView?.setListLoadingState(state: .complete(category: spotData.category, spotList: spotData.spotList))
            }
        }
    }

    /// PageViewのスクロール量が変化した時の処理
    /// - Parameters:
    ///   - scrollInfo: スクロール量の情報
    ///   - topInset: 上部の余白
    private func changeScrollInfo(scrollInfo: RecommendPageView.ScrollInfo, topInset: CGFloat) {
        // 上方向スクロールの場合
        if scrollInfo.currentTopOffset - scrollInfo.topOffset < 0, scrollInfo.topOffset > -topInset {
            scrollToTop(scrollInfo: scrollInfo, topInset: topInset)
        }
        // 下方向スクロール
        else {
            scrollToBottom(scrollInfo: scrollInfo, topInset: topInset)
        }
    }

    /// 上方向スクロールの時の処理
    private func scrollToTop(scrollInfo: RecommendPageView.ScrollInfo, topInset: CGFloat) {
        // タブViewを固定する位置
        let fixedTop = -headerView.frame.height
        // ヘッダーViewがまだ見えている場合
        if headerViewTopConstraints.constant > fixedTop {
            // ヘッダーViewの位置を上に移動させる
            let diff = scrollInfo.topOffset - scrollInfo.currentTopOffset
            var newConstant = headerViewTopConstraints.constant - diff
            // タブViewが上に固定される場合の条件
            if newConstant < fixedTop {
                newConstant = fixedTop
            }
            // ヘッダーViewの位置を確定
            headerViewTopConstraints.constant = newConstant
            // 別画面のページViewのスクロール位置を調整
            spotViewList.forEach { targetView, _ in
                // 今スクロールされているページViewの場合は何もしない
                if targetView.tag == scrollInfo.tag {
                    return
                }
                if targetView.tableView.contentOffset.y >= -topInset, targetView.tableView.contentOffset.y <= -tabView.frame.height {
                    let newOffset = CGPoint(x: 0, y: (-tabView.frame.height - headerView.frame.height) - headerViewTopConstraints.constant)
                    targetView.tableView.setContentOffset(newOffset, animated: false)
                }
            }
        }
        // ヘッダーViewが見えなくなったらその位置で固定
        else {
            headerViewTopConstraints.constant = fixedTop
            // ある程度上方向にスクロールされた場合は閉じるボタンを表示する
            if !isShowingFloatinButton, scrollInfo.topOffset >= 100 {
                showFloatingCloseButton(isShow: true)
            }
        }
    }

    /// 下方向スクロールの時の処理
    private func scrollToBottom(scrollInfo: RecommendPageView.ScrollInfo, topInset: CGFloat) {
        // scrollViewの一番上の要素が見えている場合
        if scrollInfo.topOffset <= (-topInset - headerViewTopConstraints.constant) {
            // ヘッダーViewがまだ下方向に移動できる場合
            if headerViewTopConstraints.constant < 0 {
                // ヘッダーViewの位置を下に移動させる
                let diff = scrollInfo.topOffset - scrollInfo.currentTopOffset
                var newConstant = headerViewTopConstraints.constant - diff
                // ヘッダーViewの固定位置の条件
                if newConstant > 0 {
                    newConstant = 0
                }
                // ヘッダーViewの位置を確定
                headerViewTopConstraints.constant = newConstant
                // 別画面のページViewのスクロール位置を調整
                spotViewList.forEach { targetView, _ in
                    // 今スクロールされているページViewの場合は何もしない
                    if targetView.tag == scrollInfo.tag {
                        return
                    }
                    if targetView.tableView.contentOffset.y <= 0 {
                        let newOffset = CGPoint(x: 0, y: (-tabView.frame.height - headerView.frame.height) - headerViewTopConstraints.constant)
                        targetView.tableView.setContentOffset(newOffset, animated: false)
                    }
                }
            }
            // ヘッダーViewが下へ移動できない場合：その位置で固定する
            else {
                headerViewTopConstraints.constant = 0
                // フローティング閉じるボタンを非表示にする
                if isShowingFloatinButton {
                    showFloatingCloseButton(isShow: false)
                }
            }
        }
        // scrollViewを下方向にスクロールできる場合
        else {}
    }

    /// フローティング閉じるボタンの表示を切り替える
    private func showFloatingCloseButton(isShow: Bool) {
        isShowingFloatinButton = isShow
        let beforeAlpha: CGFloat = isShow ? 0.0 : 1.0
        let afterAlpha: CGFloat = isShow ? 1.0 : 0.0
        floatCloseButton.alpha = beforeAlpha
        floatCloseButton.isHidden = false
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.floatCloseButton.alpha = afterAlpha
        }, completion: { [weak self] _ in
            self?.floatCloseButton.isHidden = !isShow
        })
    }
}

extension RecommendListViewController: UIScrollViewDelegate {
    /// ページが確定した時に呼ばれる
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexOfPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        changePage(index: indexOfPage)
    }
}

extension RecommendListViewController: RecommendListVCProtocol {
    var tapCloseButton: Driver<Void> {
        Driver.merge(closeButton.rx.tap.asDriver(), floatCloseButton.rx.tap.asDriver())
    }

    var currentPage: Driver<Int> {
        currentPageRelay.asDriver().compactMap { $0 }
    }
}

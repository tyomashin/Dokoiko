//
//  SearchLoadingViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/03.
//

import RxCocoa
import RxSwift
import UIKit

/// 検索中ローディング画面が準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchLoadingVCProtocol: AnyObject {
    /// アニメーション完了時のイベント
    var completionAnmation: Signal<Bool> { get }
}

/// 検索中ローディング画面
class SearchLoadingViewController: UIViewController {
    private var viewModel: SearchLoadingViewModelProtocol?
    private let disposeBag = DisposeBag()
    // ローディング状態
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    // ローディング状態時に右下に表示するテキストアニメーション用の配列
    private let loadingTextList = [
        L10n.SearchLoading.NowLoading.empty,
        L10n.SearchLoading.NowLoading.one,
        L10n.SearchLoading.NowLoading.two,
        L10n.SearchLoading.NowLoading.three
    ]
    // アニメーション完了時のイベント
    private let completionAnmationRelay = BehaviorRelay<Bool>(value: false)

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationBar を非表示にする。スワイプは有効にする
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        view.backgroundColor = Asset.backgroundColor.color
        headerView.backgroundColor = Asset.backgroundColor.color
        detailView.backgroundColor = Asset.backgroundColor.color
        contentView.backgroundColor = Asset.backgroundColor.color

        detailLabel.font = .systemFont(ofSize: 18)
        detailLabel.textColor = Asset.textColorDisabled.color
        loadingLabel.font = .systemFont(ofSize: 20)
        loadingLabel.textColor = Asset.primaryThinColor.color

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }

        loadingTextCount()
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: ローディング画面のViewModel
    internal func inject(viewModel: SearchLoadingViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: ViewModel
    private func bindViewModel(viewModel: SearchLoadingViewModelProtocol) {
        viewModel
            .loadingState
            .drive(onNext: { [weak self] loadingState in
                self?.handleLoadingState(state: loadingState)
            })
            .disposed(by: disposeBag)
    }

    /// ローディング状態に応じた処理
    private func handleLoadingState(state: LoadingState) {
        switch state {
        // ローディング中状態
        case .loading:
            // ローディング表示
            showLoading()

        // ローディング完了状態
        case .completion:
            // 完了アニメーション開始
            showCompletion()

        // エラー発生時
        case let .error(message):
            // アニメーションを停止
            gifImageView.animationImages = nil
            isLoadingRelay.accept(false)
            // エラーダイアログを表示する
            showMessage(title: L10n.Dialog.Title.error, message: message) { [weak self] in
                // 前画面に戻る
                self?.navigationController?.popViewController(animated: true)
            }
        // 何もしていない時
        case .idle:
            // アニメーションを停止
            gifImageView.animationImages = nil
            isLoadingRelay.accept(false)
        }
    }

    /// ローディング時の表示を行う
    private func showLoading() {
        detailLabel.text = L10n.SearchLoading.nowLoading

        // ローディング素材：https://icons8.com/preloaders/
        let images = UIImage.gifImages(resourceName: "loading")
        gifImageView.animationImages = images
        // 1回のアニメーション時間（秒）
        gifImageView.animationDuration = 1
        // リピートする
        gifImageView.animationRepeatCount = 0
        gifImageView.startAnimating()

        isLoadingRelay.accept(true)
    }

    /// ローディングテキストのカウントアップ処理
    private func loadingTextCount() {
        // 1秒ごとのタイマーに応じて「Loading」テキストの文字列を変化させる
        isLoadingRelay
            .flatMapLatest {
                $0 ? Observable<Int>.interval(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance) : Observable.empty()
            }
            .map { [weak self] in
                guard let textList = self?.loadingTextList else { return "" }
                let index = $0 % textList.count
                return textList[index]
            }
            .bind(to: loadingLabel.rx.text)
            .disposed(by: disposeBag)
    }

    /// 完了時の処理を行う
    private func showCompletion() {
        // アニメーションを停止
        gifImageView.animationImages = nil
        isLoadingRelay.accept(false)

        // 完了時の表示
        detailLabel.text = L10n.SearchLoading.complete
        loadingLabel.text = L10n.SearchLoading.finish
        gifImageView.image = Asset.loadingCompletion.image

        // 0.75 秒待機
        Observable<Int>
            .timer(RxTimeInterval.milliseconds(750), scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else {
                    return .empty()
                }
                // return Observable.of(self.fadeOutAnimation(duration: 1), self.slidinCircleView(duration: 1)).merge()
                return Observable
                    .combineLatest(self.fadeOutAnimation(duration: 0.75), self.slidinCircleView(duration: 0.75)) { _, _ in
                        ()
                    }
            }
            .subscribe(onNext: { [weak self] in
                // アニメーション完了イベントを発火
                self?.completionAnmationRelay.accept(true)
            })
            .disposed(by: disposeBag)
    }

    /// Viewのフェードアウトアニメーション
    private func fadeOutAnimation(duration: TimeInterval) -> Observable<Void> {
        Observable<Void>.create { [weak self] observer in
            func animate() {
                UIView.animate(withDuration: duration, animations: { [weak self] in
                    self?.gifImageView.alpha = 0
                    self?.detailLabel.alpha = 0
                    self?.loadingLabel.alpha = 0
                }, completion: { _ in
                    observer.onNext(())
                })
            }
            animate()
            return Disposables.create()
        }
    }

    /// 円形Viewのスライドインアニメーション
    private func slidinCircleView(duration: TimeInterval) -> Observable<Void> {
        // 2つの円形Viewを生成する処理
        let bigCircleView = UIImageView()
        let mediumCircleView = UIImageView()

        let bigCircleWidth: CGFloat = view.frame.height / 2.5
        let mediumCircleWidth: CGFloat = view.frame.height / 3
        let bigCircleTopY: CGFloat = 150

        // 円形Viewは画面右外に生成
        bigCircleView.frame = CGRect(x: view.frame.width + 10, y: bigCircleTopY, width: bigCircleWidth, height: bigCircleWidth)
        mediumCircleView.frame = CGRect(x: view.frame.width + 10, y: bigCircleTopY + bigCircleWidth + 5, width: mediumCircleWidth, height: mediumCircleWidth)

        bigCircleView.contentMode = .scaleAspectFill
        mediumCircleView.contentMode = .scaleAspectFill
        bigCircleView.image = Asset.bigCircle.image
        mediumCircleView.image = Asset.mediumCircle.image

        view.addSubview(bigCircleView)
        view.addSubview(mediumCircleView)

        // アニメーションを実施するObservableを生成
        return Observable<Void>.create { [weak self] observer in
            func animate() {
                guard let self = self else { return }
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                    bigCircleView.frame.origin.y += 200
                    bigCircleView.frame.origin.x -= self.view.frame.width + bigCircleView.frame.width + 100
                    mediumCircleView.frame.origin.y += 200
                    mediumCircleView.frame.origin.x -= self.view.frame.width + mediumCircleView.frame.width + 100
                }, completion: { _ in
                    bigCircleView.removeFromSuperview()
                    mediumCircleView.removeFromSuperview()
                    observer.onNext(())
                })
            }
            animate()
            return Disposables.create()
        }
    }
}

extension SearchLoadingViewController: SearchLoadingVCProtocol {
    // アニメーション完了イベント
    var completionAnmation: Signal<Bool> {
        completionAnmationRelay.asSignal(onErrorJustReturn: false)
    }
}

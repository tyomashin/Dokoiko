//
//  SearchResultViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/24.
//

import Lottie
import RxCocoa
import RxSwift
import UIKit

/// 検索結果画面が準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchResultVCProtocol: AnyObject {
    /// 閉じるボタンがタップされた時のイベント
    var tapCloseButton: Driver<Void> { get }
    /// 地図で検索ボタンがタップされた時のイベント
    var tapMapButton: Driver<Void> { get }
    /// Web検索ボタンタップ時のイベント
    var tapWebSearchButton: Driver<Void> { get }
    /// 推薦ボタンタップ時のイベント
    var tapRecommendButton: Driver<Void> { get }
}

/// 検索結果画面
class SearchResultViewController: UIViewController {
    private var viewModel: SearchResultViewModelProtocol?
    private let disposeBag = DisposeBag()
    private var animationView: AnimationView?

    @IBOutlet weak var spotlightImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var spotlightCircleImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityDetailLabel: UILabel!
    @IBOutlet weak var spotSearchLabel: UILabel!
    @IBOutlet weak var panelAreaView: UIView!
    @IBOutlet weak var webSearchPanel: SearchResultPanelButton!
    @IBOutlet weak var recommendPanel: SearchResultPanelButton!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 見た目の設定
        setViewsAppearance()
        setViewsEventAppearance()

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: 検索結果画面のViewModel
    internal func inject(viewModel: SearchResultViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: 検索結果画面のViewModel
    private func bindViewModel(viewModel: SearchResultViewModelProtocol) {
        viewModel
            .animationData
            .drive(onNext: { [weak self] animationData in
                // アニメーションする場合
                if animationData.isAnimation {
                    self?.startAnimation(cityName: animationData.cityName)
                }
                // アニメーションなしの場合
                else {
                    self?.setCompletionState(cityName: animationData.cityName)
                }
            })
            .disposed(by: disposeBag)
    }

    /// 見た目の設定を行う
    private func setViewsAppearance() {
        view.backgroundColor = Asset.primaryDarkColor.color
        headerView.backgroundColor = Asset.primaryDarkColor.color
        searchResultView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)

        spotlightImageView.isHidden = true; headerView.isHidden = true; searchResultView.isHidden = true
        spotlightCircleImageView.isHidden = true; cityNameLabel.isHidden = true; cityDetailLabel.isHidden = true
        panelAreaView.isHidden = true; closeButton.isHidden = true

        cityNameLabel.font = .systemFont(ofSize: 36, weight: .bold)
        cityDetailLabel.font = .systemFont(ofSize: 12)
        cityNameLabel.textColor = Asset.primaryColor.color
        cityDetailLabel.textColor = Asset.primaryColor.color
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: L10n.SearchResult.MapTransition.title, attributes: underlineAttribute)
        cityDetailLabel.attributedText = underlineAttributedString

        spotSearchLabel.text = L10n.SearchResult.SpotSearch.title
        spotSearchLabel.textColor = Asset.textColor.color
        spotSearchLabel.font = .systemFont(ofSize: 18, weight: .bold)

        closeButton.layer.cornerRadius = 30
        closeButton.setTitle(L10n.Btn.close, for: .normal)
        closeButton.setTitleColor(Asset.textThinColor.color, for: .normal)
        closeButton.backgroundColor = Asset.backgroundColor.color
        closeButton.addBorderFrame(color: Asset.strokeColor.color)

        panelAreaView.backgroundColor = Asset.backgroundColorPurple.color
        panelAreaView.layer.cornerRadius = 10
        webSearchPanel.layer.cornerRadius = 10
        webSearchPanel.setViewDetails(title: L10n.SearchResult.SpotSearch.Web.title, iconImage: Asset.webSearchIcon.image)
        recommendPanel.layer.cornerRadius = 10
        recommendPanel.setViewDetails(title: L10n.SearchResult.SpotSearch.Recommend.title, iconImage: Asset.recommendSearchIcon.image)
    }

    /// ボタンタップ時の見た目制御
    private func setViewsEventAppearance() {
        mapButton
            .rx.controlEvent([.touchUpOutside, .touchUpInside])
            .subscribe(onNext: { [weak self] in
                self?.searchResultView.alpha = 1
            })
            .disposed(by: disposeBag)

        mapButton
            .rx.controlEvent([.touchDown])
            .subscribe(onNext: { [weak self] in
                self?.searchResultView?.alpha = 0.6
            })
            .disposed(by: disposeBag)
    }

    /// アニメーション完了後状態の画面表示に設定する
    private func setCompletionState(cityName: String) {
        cityNameLabel.text = cityName

        view.backgroundColor = Asset.backgroundColor.color
        headerView.backgroundColor = Asset.backgroundColor.color

        headerView.isHidden = false
        searchResultView.isHidden = false
        spotlightCircleImageView.isHidden = false
        cityNameLabel.isHidden = false
        cityDetailLabel.isHidden = false
        panelAreaView.isHidden = false
        closeButton.isHidden = false
    }

    /// 検索結果アニメーションを開始する
    private func startAnimation(cityName: String) {
        // 開始ラベル
        let startLabel = UILabel()
        startLabel.textColor = Asset.textColorWhite.color
        startLabel.numberOfLines = 2
        startLabel.text = L10n.SearchResult.StartTitle.title
        startLabel.alpha = 0
        startLabel.font = .systemFont(ofSize: 20)
        startLabel.textAlignment = .center
        view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        startLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        startLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        startLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

        // アニメーション前に少し待機
        Observable<Int>.timer(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                // 開始ラベルのフェードインアニメーション
                return self.fadeInAnimationWithLabel(startLabel: startLabel, dulation: 1)
            }
            .flatMap { _ -> Observable<Int> in
                // 少し待つ
                Observable<Int>.timer(RxTimeInterval.milliseconds(750), scheduler: MainScheduler.instance)
            }
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                // 開始ラベルのフェードアウトアニメーション
                return self.fadeOutAnimationWithLabel(startLabel: startLabel, dulation: 1)
            }
            .subscribe(onNext: { [weak self] _ in
                startLabel.removeFromSuperview()
                // 検索結果表示アニメーション
                self?.showSearchResultAnimation(cityName: cityName)
            })
            .disposed(by: disposeBag)
    }

    /// 開始ラベルのフェードインアニメーション
    private func fadeInAnimationWithLabel(startLabel: UILabel, dulation: TimeInterval) -> Observable<Void> {
        Observable<Void>.create { observer in
            func animate() {
                UIView.animate(withDuration: dulation, animations: {
                    startLabel.alpha = 1
                }, completion: { _ in
                    observer.onNext(())
                })
            }
            animate()
            return Disposables.create()
        }
    }

    /// 開始ラベルのフェードアウトアニメーション
    private func fadeOutAnimationWithLabel(startLabel: UILabel, dulation: TimeInterval) -> Observable<Void> {
        Observable<Void>.create { observer in
            func animate() {
                UIView.animate(withDuration: dulation, animations: {
                    startLabel.alpha = 0
                }, completion: { _ in
                    observer.onNext(())
                })
            }
            animate()
            return Disposables.create()
        }
    }

    /// 検索結果表示アニメーション
    private func showSearchResultAnimation(cityName: String) {
        cityNameLabel.text = cityName

        // アニメーション前に少し待機
        Observable<Int>.timer(RxTimeInterval.milliseconds(250), scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<Int> in
                guard let self = self else { return .empty() }
                // 検索都市の表示処理
                self.searchResultView.isHidden = false
                self.spotlightImageView.isHidden = false
                self.spotlightCircleImageView.isHidden = false
                self.cityNameLabel.isHidden = false
                // 結果表示後に一瞬だけ待機
                return Observable<Int>.timer(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            }
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                // 完了時のフェードインアニメーション
                return self.completionAnimationFadeIn(dulation: 0.5)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    /// 完了アニメーション（フェードイン）
    private func completionAnimationFadeIn(dulation: TimeInterval) -> Observable<Void> {
        headerView.alpha = 0
        cityDetailLabel.alpha = 0
        closeButton.alpha = 0
        panelAreaView.alpha = 0

        headerView.isHidden = false
        cityDetailLabel.isHidden = false
        closeButton.isHidden = false
        panelAreaView.isHidden = false

        // 紙吹雪を表示する
        showConfetti()

        return Observable<Void>.create { observer in
            func animate() {
                UIView.animate(withDuration: dulation, animations: { [weak self] in
                    self?.view.backgroundColor = Asset.backgroundColor.color
                    self?.headerView.backgroundColor = Asset.backgroundColor.color
                    self?.headerView.alpha = 1
                    self?.cityDetailLabel.alpha = 1
                    self?.closeButton.alpha = 1
                    self?.panelAreaView.alpha = 1
                    self?.spotlightImageView.alpha = 0
                }, completion: { _ in
                    observer.onNext(())
                })
            }
            animate()
            return Disposables.create()
        }
    }

    /// 紙吹雪を表示
    private func showConfetti() {
        // 紙吹雪を表示
        // https://lottiefiles.com/search?q=confetti&category=animations
        let animationView = AnimationView(name: "confetti")
        animationView.isUserInteractionEnabled = false
        self.animationView = animationView
        self.animationView?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.animationView?.center = view.center
        self.animationView?.loopMode = .loop
        self.animationView?.contentMode = .scaleAspectFit
        self.animationView?.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()

        // 1秒間表示する
        Observable<Int>
            .timer(RxTimeInterval.milliseconds(5000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.5, animations: { [weak self] in
                    self?.animationView?.alpha = 0
                }, completion: { [weak self] _ in
                    self?.animationView?.removeFromSuperview()
                })
            })
            .disposed(by: disposeBag)
    }
}

extension SearchResultViewController: SearchResultVCProtocol {
    var tapCloseButton: Driver<Void> {
        closeButton.rx.tap.asDriver()
    }

    var tapMapButton: Driver<Void> {
        mapButton.rx.tap.asDriver()
    }

    var tapWebSearchButton: Driver<Void> {
        webSearchPanel.coverButton.rx.tap.asDriver()
    }

    var tapRecommendButton: Driver<Void> {
        recommendPanel.coverButton.rx.tap.asDriver()
    }
}

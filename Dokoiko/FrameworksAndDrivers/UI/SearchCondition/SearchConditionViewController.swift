//
//  SearchConditionViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/04.
//

import RxCocoa
import RxSwift
import UIKit

/// 検索条件画面が準拠するプロトコル
protocol SearchConditionVCProtocol: AnyObject {
    /// 戻るボタンタップ時のイベント
    var tapBackButton: ControlEvent<Void> { get }
    /// 検索ボタンタップ時のイベント
    var tapSearchButton: ControlEvent<Void> { get }
    /// 選択された検索条件のイベント
    var selectedSearchCondition: Driver<Int> { get }
    /// エリアが選択された時のイベント
    var areaSelectedIndex: Driver<Int> { get }
    /// 都道府県が選択された時のイベント
    var prefectureSelectedIndex: Driver<Int> { get }
    /// 地点が選択された時のイベント
    var selectedLocation: Driver<(lat: Double, lng: Double)> { get }
    /// 半径が選択された時のイベント
    var selectedRadius: Driver<Float> { get }
}

/// 検索条件画面
class SearchConditionViewController: UIViewController {
    private var viewModel: SearchConditionViewModelProtocol?

    private let disposeBag = DisposeBag()

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bottonView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchConditionSelectionView: SearchConditionSelectView!
    @IBOutlet weak var searchConditionSelectViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchConditionPrefecturesView: SearchConditionPrefecturesView!
    @IBOutlet weak var searchConditionCurrentLocationView: SearchConditionCurrentLocationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Asset.backgroundColor.color
        topView.backgroundColor = Asset.backgroundColor.color

        titleLabel.text = L10n.Title.searchCondition
        titleLabel.textColor = Asset.textColor.color
        titleLabel.font = .boldSystemFont(ofSize: 20)

        backImageView.image = Asset.backButton.image.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = Asset.textColor.color

        bottonView.backgroundColor = Asset.backgroundColor.color
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 20
        searchButton.isEnabled = false
        searchButton.setBackgroundImage(UIImage.colorImage(withColor: Asset.subPinkColor.color), for: .normal)
        searchButton.setBackgroundImage(UIImage.colorImage(withColor: Asset.backgroundColorPurple.color), for: .disabled)
        searchButton.setBackgroundImage(UIImage.colorImage(withColor: Asset.subPinkColor.color), for: .highlighted)
        searchButton.setTitle(L10n.Btn.SearchCondition.search, for: .normal)
        searchButton.setTitleColor(Asset.textColorWhite.color, for: .normal)
        searchButton.setTitleColor(Asset.textColorDisabled.color, for: .disabled)

        searchConditionPrefecturesView.isHidden = true
        searchConditionCurrentLocationView.isHidden = true

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }

        searchConditionSelectionView.rx.myHeight
            .drive(onNext: { [weak self] myHeight in
                self?.searchConditionSelectViewHeightConstraint.constant = myHeight
            })
            .disposed(by: disposeBag)

        // Do any additional setup after loading the view.
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: 検索条件画面のViewModel
    internal func inject(viewModel: SearchConditionViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: メイン画面のViewModel
    private func bindViewModel(viewModel: SearchConditionViewModelProtocol) {
        // 検索方法の選択可能リスト
        viewModel
            .searchConditionTypeList
            .drive(searchConditionSelectionView.rx.conditionTypeList)
            .disposed(by: disposeBag)

        // 選択されている検索方法
        viewModel
            .selectedSearchConditionType
            .drive(onNext: { [weak self] type in
                self?.setSearchConditionType(searchType: type)
            })
            .disposed(by: disposeBag)

        // 「都道府県から検索」の場合の検索条件
        viewModel
            .searchConditionPrefectures
            .drive(searchConditionPrefecturesView.rx.searchCondication)
            .disposed(by: disposeBag)

        // 「現在地の近くから検索」の場合の検索条件
        viewModel
            .searchConditionCurrentLocation
            .drive(searchConditionCurrentLocationView.rx.searchCondication)
            .disposed(by: disposeBag)

        // 現在地
        viewModel
            .currentLocation
            .drive(searchConditionCurrentLocationView.rx.currentLocation)
            .disposed(by: disposeBag)

        // 検索ボタンの活性状態を切り替える
        viewModel
            .searchPermission
            .drive(searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    /// 選択された検索方法に基づいて画面表示切り替え
    private func setSearchConditionType(searchType: SearchConditionType) {
        switch searchType {
        case .prefectures:
            searchConditionPrefecturesView.isHidden = false
            searchConditionCurrentLocationView.isHidden = true

        case .currentLocation:
            if searchConditionCurrentLocationView.isHidden {
                searchConditionCurrentLocationView.mapView.alpha = 0
                UIView.animate(withDuration: 0.5, animations: { [weak self] in
                    self?.searchConditionCurrentLocationView.mapView.alpha = 1
                })
            }
            searchConditionPrefecturesView.isHidden = true
            searchConditionCurrentLocationView.isHidden = false
        }
    }
}

extension SearchConditionViewController: SearchConditionVCProtocol {
    var tapBackButton: ControlEvent<Void> {
        backButton.rx.tap
    }

    var tapSearchButton: ControlEvent<Void> {
        searchButton.rx.tap
    }

    var selectedSearchCondition: Driver<Int> {
        searchConditionSelectionView.rx.selectedItem
    }

    var areaSelectedIndex: Driver<Int> {
        searchConditionPrefecturesView.rx.areaSelectedIndex
    }

    var prefectureSelectedIndex: Driver<Int> {
        searchConditionPrefecturesView.rx.prefectureSelectedIndex
    }

    var selectedLocation: Driver<(lat: Double, lng: Double)> {
        searchConditionCurrentLocationView.rx.selectedLocation
    }

    var selectedRadius: Driver<Float> {
        searchConditionCurrentLocationView.rx.selectedRadius
    }
}

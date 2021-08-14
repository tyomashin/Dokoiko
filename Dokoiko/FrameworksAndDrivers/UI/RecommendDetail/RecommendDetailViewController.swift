//
//  RecommendDetailViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/09.
//

import GoogleMaps
import RxCocoa
import RxSwift
import UIKit

/// 推薦詳細画面が準拠するプロトコル
/// sourcery: AutoMockable
protocol RecommendDetailVCProtocol: AnyObject {
    /// 閉じるボタンがタップされた時のイベント
    var tapCloseButton: Driver<Void> { get }
    /// 戻るボタンがタップされた時のイベント
    var tapBackButton: Driver<Void> { get }
    /// Webサイトボタンがタップされた時のイベント
    var tapWebButton: Driver<Void> { get }
    /// 経路案内ボタンがタップされた時のイベント
    var tapRouteButton: Driver<Void> { get }
    /// クーポンがタップされた時のイベント
    var tapCoupon: Driver<RecommendSpotCoupon> { get }
}

/// 推薦詳細画面
class RecommendDetailViewController: UIViewController {
    private var viewModel: RecommendDetailViewModelProtocol?
    private let disposeBag = DisposeBag()
    // マップ上のマーカー
    private var marker = GMSMarker()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!

    @IBOutlet weak var spotImageAreaView: UIView!
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var recommendDetailLinkAreaView: RecommendDetailLinkAreaView!
    @IBOutlet weak var genreAreaView: UIView!
    @IBOutlet weak var genreStackView: UIStackView!

    @IBOutlet weak var spotNameAreaView: UIView!
    @IBOutlet weak var spotNameLabel: UILabel!

    @IBOutlet weak var distanceAreaView: UIView!
    @IBOutlet weak var distanceIconLabelView: IconLabelView!

    @IBOutlet weak var couponAreaView: RecommendDetailCouponAreaView!

    @IBOutlet weak var accessAreaView: UIView!
    @IBOutlet weak var accessTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!

    @IBOutlet weak var googleMapAreaView: UIView!
    @IBOutlet weak var gmsMapView: GMSMapView!

    @IBOutlet weak var emptyView: UIView!

    @IBOutlet weak var spotNameAreaViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var couponAreaViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationBar を非表示にする。スワイプは有効にする
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        view.backgroundColor = Asset.backgroundColorWhite.color
        headerView.backgroundColor = Asset.backgroundColorWhite.color
        titleLabel.textColor = Asset.textColor.color
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = L10n.SpotDetail.title

        closeImageView.image = Asset.outlineCloseBlack.image
        closeImageView.contentMode = .scaleAspectFit
        closeImageView.tintColor = Asset.textColor.color

        backImageView.image = Asset.backButton.image
        backImageView.contentMode = .scaleAspectFit
        backImageView.tintColor = Asset.textColor.color

        spotImageView.contentMode = .scaleAspectFit

        spotImageAreaView.addBackgroundBlur()
        spotImageAreaView.backgroundColor = Asset.primaryColor.color
        genreAreaView.backgroundColor = Asset.backgroundColorWhite.color
        spotNameAreaView.backgroundColor = Asset.backgroundColorWhite.color
        distanceAreaView.backgroundColor = Asset.backgroundColorWhite.color
        distanceIconLabelView.baseView.backgroundColor = Asset.backgroundColorWhite.color
        couponAreaView.backgroundColor = Asset.backgroundColorWhite.color
        accessAreaView.backgroundColor = Asset.backgroundColorWhite.color
        googleMapAreaView.backgroundColor = Asset.backgroundColorWhite.color

        spotNameLabel.textColor = Asset.textColor.color
        spotNameLabel.font = .boldSystemFont(ofSize: 24)
        accessTitleLabel.text = L10n.Access.title
        accessTitleLabel.textColor = Asset.textColor.color
        accessTitleLabel.font = .boldSystemFont(ofSize: 18)
        addressLabel.textColor = Asset.textThinColor.color
        addressLabel.font = .systemFont(ofSize: 14)
        telLabel.textColor = Asset.textThinColor.color
        telLabel.font = .systemFont(ofSize: 13)

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: 推薦詳細画面のViewModel
    internal func inject(viewModel: RecommendDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: 推薦詳細画面のViewModel
    private func bindViewModel(viewModel: RecommendDetailViewModelProtocol) {
        viewModel
            .spotEntityData
            .drive(onNext: { [weak self] spotInfo in
                self?.setSpotDetail(spotEntity: spotInfo.spot, spotCategory: spotInfo.category)
            })
            .disposed(by: disposeBag)

        viewModel
            .errorMessage
            .drive(onNext: { [weak self] message in
                self?.showMessage(title: "", message: message, tapOk: nil)
            })
            .disposed(by: disposeBag)
    }

    /// スポット情報を画面表示
    private func setSpotDetail(spotEntity: RecommendSpotEntity, spotCategory: SpotCategory) {
        // スポット画像
        setDefaultImage(category: spotCategory)
        // 画像URLがあれば
        if let urlStr = spotEntity.imageUrl {
            UIImage.getImageWithKingfisher(urlStr: urlStr) { [weak self] image in
                self?.spotImageView?.image = image
            }
        }

        // ジャンルを設定
        setGenreList(entity: spotEntity)

        // スポット名
        spotNameLabel.text = spotEntity.name
        setSpotNameHeight()

        // 距離アイコンViewのセット
        var distanceStr = "--"
        if let distance = spotEntity.distanceKM {
            distanceStr = String(format: "%.1f km", distance)
        }
        distanceIconLabelView.setDetails(title: distanceStr, icon: Asset.directionsCarFilledBlack.image)

        // クーポン
        let couponHeight = couponAreaView.setDetails(couponList: spotEntity.coupons ?? [])
        if couponHeight <= 0 {
            couponAreaView.isHidden = true
        } else {
            couponAreaView.isHidden = false
            couponAreaViewHeightConstraint.constant = couponHeight
            couponAreaViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        }

        // 住所
        addressLabel.text = spotEntity.address ?? L10n.SpotDetail.Address.empty
        // 電話番号
        telLabel.text = spotEntity.tel ?? L10n.SpotDetail.Tel.empty

        // マップ上にマーカーをセット
        if let lat = spotEntity.lat, let lng = spotEntity.lng {
            setMapMarker(lat: lat, lng: lng)
        }
    }

    /// デフォルト画像をセットする
    private func setDefaultImage(category: SpotCategory) {
        // カテゴリごとのデフォルト画像をセット
        switch category {
        case .restaurant:
            spotImageView.image = Asset.restaurantDefaultImage.image

        case .shopping:
            spotImageView.image = Asset.shoppingDefaultImage.image

        case .leisure:
            spotImageView.image = Asset.leisureDefaultImage.image

        case .lifestyle:
            spotImageView.image = Asset.lifestyleDefaultImage.image
        }
    }

    /// マップ上にマーカーをセットする
    private func setMapMarker(lat: Double, lng: Double) {
        marker.map = nil
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let newMarker = GMSMarker(position: position)

        marker = newMarker
        marker.map = gmsMapView

        moveCamera(lat: lat, lng: lng)
    }

    /// マップ上のカメラ移動
    private func moveCamera(lat: Double, lng: Double, zoom: Float = 13) {
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        // カメラを移動
        let camera = GMSCameraPosition(target: position, zoom: zoom)
        gmsMapView.animate(to: camera)
    }

    /// スポット名の高さを調整する
    private func setSpotNameHeight() {
        spotNameLabel.layoutIfNeeded()
        let maxSize = CGSize(width: spotNameLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)
        var targetHeight: CGFloat = 10
        targetHeight += spotNameLabel.sizeThatFits(maxSize).height
        spotNameAreaViewHeightConstraint.constant = targetHeight
    }

    /// ジャンルStackViewをセット
    private func setGenreList(entity: RecommendSpotEntity) {
        guard let genreList = entity.genre else {
            return
        }

        // 表示できる横幅計算用
        var totalWidth: CGFloat = 0
        let maxWidth: CGFloat = genreAreaView.frame.width - 40
        let spacing: CGFloat = genreStackView.spacing

        for genre in genreList {
            let genreView = LabelView(frame: .zero)
            let tmpWidth = genreView.setDetails(text: genre, textColor: Asset.textColorWhite.color, viewColor: Asset.subPinkColor.color, textSize: 12)
            totalWidth += tmpWidth + spacing
            if totalWidth >= maxWidth {
                break
            }
            genreStackView.addArrangedSubview(genreView)
            genreView.translatesAutoresizingMaskIntoConstraints = false
            genreView.widthAnchor.constraint(equalToConstant: tmpWidth).isActive = true
        }
    }
}

extension RecommendDetailViewController: RecommendDetailVCProtocol {
    var tapCloseButton: Driver<Void> {
        closeButton.rx.tap.asDriver()
    }

    var tapBackButton: Driver<Void> {
        backButton.rx.tap.asDriver()
    }

    var tapWebButton: Driver<Void> {
        recommendDetailLinkAreaView.leftLinkButton.coverButton.rx.tap.asDriver()
    }

    var tapRouteButton: Driver<Void> {
        recommendDetailLinkAreaView.rightLinkButton.coverButton.rx.tap.asDriver()
    }

    var tapCoupon: Driver<RecommendSpotCoupon> {
        couponAreaView.rx.selectedCoupon
    }
}
